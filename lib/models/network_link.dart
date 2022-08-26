
class NetworkLink{
  late String link;

  NetworkLink({required String link}){
    if(link != ''){
      this.link = 'https://www.msdr.news/$link';
    }else{
      this.link = '';
    }
  }
}