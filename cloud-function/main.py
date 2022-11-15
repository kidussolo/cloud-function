import functions_framework

@functions_framework.http
def hello_http(request):
    print("hello world")
    return 'OK'