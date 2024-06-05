enum CallState { EMPTY, PROGRESS, SUCCESS, ERROR }

class Response<T extends Object> {
  late CallState status;
  late String mesage = '';
  late T? data;

  Response({required this.status, required this.mesage, this.data});

  factory Response.empty({String msg = ''}) {
    return Response(status: CallState.EMPTY, mesage: msg, data: null);
  }

  factory Response.progress({String msg = ''}) {
    return Response(status: CallState.PROGRESS, mesage: msg);
  }
  factory Response.success({String msg = '', T? data}) {
    return Response(status: CallState.SUCCESS, mesage: msg, data: data);
  }

  factory Response.error({String msg = ''}) {
    return Response(status: CallState.ERROR, mesage: msg);
  }

  bool isSuccess() => status == CallState.SUCCESS;
  bool isError() => status == CallState.ERROR;
  bool isProgress() => status == CallState.PROGRESS;
  bool isEmpty() => status == CallState.EMPTY;
}
