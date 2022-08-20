
class NetworkLink{
  late String link;

  NetworkLink({required String link}){
    this.link = 'https://www.msdr.news/$link';
  }
}