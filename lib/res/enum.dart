
enum NetworkStatus { initial , loading , success, failure,successDialog, errorDialog }

extension on NetworkStatus{
   // bool get isInitial => this == NetworkStatus.initial;
   // bool get isLoading => this == NetworkStatus.loading;
   // // bool get issuccess => this == NetworkStatus.success;
   // // bool get isfailure => this == NetworkStatus.failure;
}


enum Filter {open, close, all}