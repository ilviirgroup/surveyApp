from django.contrib.auth.models import AbstractUser
from django.db import models
from django.conf import settings


class Questions(models.Model):
    question = models.CharField(max_length=1000, null=True)

    def __str__(self):
        return self.question


class Results(models.Model):
    results = models.CharField(max_length=1000, null=True)
    question = models.ForeignKey(Questions, on_delete=models.CASCADE, null=True)

    def __str__(self):
        return self.results


class User_results(models.Model):
    user_results = models.CharField(max_length=1000, null=True)
    user_question = models.CharField(null=True, max_length=1000)
    author = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)

    def __str__(self):
        return self.results


class AppUsers(AbstractUser):
    phone = models.IntegerField(null=True)
