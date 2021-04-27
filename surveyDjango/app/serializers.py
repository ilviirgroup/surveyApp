from rest_framework import serializers
from django.conf import settings
from .models import Questions, Results, User_results


class QuestionSerializer(serializers.ModelSerializer):

    class Meta:
        model = Questions
        fields = ('url', 'question', 'pk')


class ResultSerializer(serializers.ModelSerializer):
    question = serializers.SlugRelatedField(queryset=Questions.objects.all(), slug_field='question')

    class Meta:
        model = Results
        fields = ('url', 'pk', 'results', 'question')


class UserResultSerializer(serializers.ModelSerializer):

    class Meta:
        model = User_results
        fields = ('url', 'pk', 'user_results', 'user_question')


