class Veiculo {
  String modelo;

  Veiculo(this.modelo);

  void acelerar() {
    print("O veículo $modelo está acelerando");
  }
}

class Carro extends Veiculo {
  Carro(String modelo) : super(modelo);

  void abrirPorta() {
    print("Abrindo a porta do carro $modelo");
  }
}

void main() {
  Carro meuCarro = Carro("Fusca");

  meuCarro.acelerar();
  meuCarro.abrirPorta();
}