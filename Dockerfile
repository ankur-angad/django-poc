###########
# BUILDER #
###########

# pulling official base image
FROM python:3.9 as builder

# environment variables
ENV PYTHONUNDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# creating and setting working directory
WORKDIR /code

# copy project and possibly associated files
COPY . /code/
COPY requirements.txt .

# installing dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    python3-dev \
    libsasl2-dev


#########
# FINAL #
#########

# pull official base image
FROM python:3.9

# create directory for the app user
RUN mkdir -p /code/app

#TODO create the app user
#RUN addgroup --system appgroup && adduser --system --group app

# create the appropriate directories
ENV HOME=/code/app
ENV APP_HOME=/code/app/web
RUN mkdir $APP_HOME \
    $APP_HOME/staticfiles
WORKDIR $APP_HOME

# copy from builder
COPY --from=builder /code/requirements.txt .

# install dependencies
RUN apt-get update && apt-get install -y \
    lcov \
    libxmlsec1-dev \
    pkg-config \
    xmlsec1
RUN pip install --upgrade pip
RUN pip install --no-cache -r requirements.txt
# copy project
COPY . $APP_HOME
WORKDIR /code
#TODO chown all the files to the app user
#RUN chown -R app:app $APP_HOME

#TODO change to the app user
#USER app

# run entrypoint.sh
#ENTRYPOINT ["/code/entrypoint.sh"]