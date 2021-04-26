from rest_framework import serializers
from django.conf import settings
from .models import Questions, Results, AppUsers, User_results


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
        fields = ('url', 'pk', 'user_results', 'user_question', 'author')


class UserSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)

    class Meta:
        model = AppUsers
        fields = ('url', 'username', 'phone', 'email', 'password')
        write_only_fields = 'password'

        def create(self, validated_data):
            user = AppUsers.objects.create(username=validated_data['username'], email=validated_data['email'],
                                           phone=validated_data['phone'])
            user.set_password(validated_data['password'])
            user.save()
            return user
