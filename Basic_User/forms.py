from django import forms
from Basic_User.models import UserProfileModel
from django.contrib.auth.models import User

class UserProfileForm(forms.ModelForm):
    password=forms.CharField(widget=forms.PasswordInput())

    class Meta:
        model=User
        fields=('username','email','password')

class UserProfileInfoForm(forms.ModelForm):
    class Meta:
        model=UserProfileModel
        fields=('portfolio_site','profile_image')