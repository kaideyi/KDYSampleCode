from django.urls import path
from . import views

urlpatterns = [
    # http://localhost:8000/blog/
    path('', views.blog_list, name='blog_list'),
    # http://localhost:8000/blog/1
    path('<int:blog_pk>', views.blog_detail, name='blog_detail'),
    # http://localhost:8000/blog/type/1
    path('type/<int:blog_type_pk>', views.blogs_with_type, name='blogs_with_type'),
]
