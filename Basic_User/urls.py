from django.conf.urls import url
from django.urls import path
from Basic_User import views


app_name='Basic_User'


urlpatterns=[
    path('register/', views.register,name='register'),
    path('user_login/', views.user_login,name='user_login'),
]