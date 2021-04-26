from django.shortcuts import render, redirect, Http404
from .forms import *
from .models import User_results, AppUsers, Questions, Results


def login(request):
    pass


def index(request):
    quest = Questions.objects.all()
    ans = User_results.objects.all()
    context = {'quest': quest, 'ans': ans}
    return render(request, 'index.html', context)


def personal_room(request,user_id):
    pass


def test(request):
    pass
