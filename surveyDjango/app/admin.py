from django.contrib import admin
from .models import Results, Questions, AppUsers, User_results


admin.site.register(Results)
admin.site.register(AppUsers)
admin.site.register(Questions)
admin.site.register(User_results)
