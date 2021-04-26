from rest_framework import generics
from .models import Results, Questions, AppUsers, User_results
from .serializers import ResultSerializer, QuestionSerializer, UserSerializer, UserResultSerializer
from rest_framework.response import Response
from rest_framework.reverse import reverse


class ResultList(generics.ListCreateAPIView):
    queryset = Results.objects.all()
    serializer_class = ResultSerializer
    name = 'result-list'


class ResultDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Results.objects.all()
    serializer_class = ResultSerializer
    name = 'results-detail'


class UserResultList(generics.ListCreateAPIView):
    queryset = User_results.objects.all()
    serializer_class = UserResultSerializer
    name = 'user_result-list'


class UserResultDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = User_results.objects.all()
    serializer_class = UserResultSerializer
    name = 'user_results-detail'


class QuestionList(generics.ListCreateAPIView):
    queryset = Questions.objects.all()
    serializer_class = QuestionSerializer
    name = 'questions-list'


class QuestionDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Questions.objects.all()
    serializer_class = QuestionSerializer
    name = 'questions-detail'


class UserList(generics.ListCreateAPIView):
    queryset = AppUsers.objects.all()
    serializer_class = UserSerializer
    name = 'appusers-list'


class UserDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = AppUsers.objects.all()
    serializer_class = UserSerializer
    name = 'appusers-detail'


class ApiRoot(generics.GenericAPIView):
    name = 'Test'

    def get(self, request, *args, **kwargs):
        return Response({
            'result': reverse(ResultList.name, request=request),
            'user_result': reverse(UserResultList.name, request=request),
            'question': reverse(QuestionList.name, request=request),
            'user': reverse(UserList.name, request=request)
        })
