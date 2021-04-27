from django.conf.urls import url
from django.urls import path
from . import views
from . import v_serializer

urlpatterns = [
    url(r'^results-list/$', v_serializer.ResultList.as_view(), name=v_serializer.ResultList.name),
    url(r'^results-list/(?P<pk>[0-9]+)$', v_serializer.ResultDetail.as_view(), name=v_serializer.ResultDetail.name),

    url(r'^user_results-list/$', v_serializer.UserResultList.as_view(), name=v_serializer.UserResultList.name),
    url(r'^user_results-list/(?P<pk>[0-9]+)$', v_serializer.UserResultDetail.as_view(), name=v_serializer.UserResultDetail.name),

    url(r'^questions-list/$', v_serializer.QuestionList.as_view(), name=v_serializer.QuestionList.name),
    url(r'^questions-list/(?P<pk>[0-9]+)$', v_serializer.QuestionDetail.as_view(), name=v_serializer.QuestionDetail.name),

    url(r'^$', v_serializer.ApiRoot.as_view(), name=v_serializer.ApiRoot.name)
]