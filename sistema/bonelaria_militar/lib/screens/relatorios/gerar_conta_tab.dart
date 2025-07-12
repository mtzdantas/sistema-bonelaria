import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/pedidos.dart';
import '../../models/funcionario.dart';
import '../../services/pedido_service.dart';
import '../../services/conta_service.dart';
import '../../services/costureira_service.dart';

class GerarContaTab extends StatefulWidget {
  const GerarContaTab({super.key});

  @override
  State<GerarContaTab> createState() => _GerarContaTabState();
}

class _GerarContaTabState extends State<GerarContaTab> {
  Funcionario? costureiraSelecionada;
  List<Funcionario> costureiras = [];
  List<Pedido> pedidos = [];
  double valorTotal = 0;
  bool carregando = false;
  final formatador = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  @override
  void initState() {
    super.initState();
    carregarCostureiras();
  }

  Future<void> carregarCostureiras() async {
    try {
      final lista = await CostureiraService.buscarTodas();
      setState(() {
        costureiras = lista;
      });
    } catch (e) {
      debugPrint('Erro ao carregar costureiras: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar costureiras')),
      );
    }
  }

  Future<void> carregarPedidos() async {
    if (costureiraSelecionada == null) return;

    setState(() {
      carregando = true;
    });

    try {
      final lista = await PedidoService.buscarFinalizadosSemConta(costureiraSelecionada!.idFuncionario);
      final valor = await PedidoService.calcularValorTotalPedidos(lista);
      setState(() {
        pedidos = lista;
        valorTotal = valor;
      });
    } catch (e) {
      debugPrint('Erro ao carregar pedidos: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar pedidos')),
      );
    } finally {
      setState(() {
        carregando = false;
      });
    }
  }

  Future<void> gerarConta() async {
    if (pedidos.isEmpty) return;

    try {
      await ContaService.gerarContaParaPedidos(pedidos, valorTotal);
      setState(() {
        pedidos = [];
        valorTotal = 0;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Conta gerada com sucesso!')),
      );
    } catch (e) {
      debugPrint('Erro ao gerar conta: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao gerar conta')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButtonFormField<Funcionario>(
            hint: const Text('Selecione uma costureira'),
            value: costureiraSelecionada,
            items: costureiras.map((c) {
              return DropdownMenuItem(
                value: c,
                child: Text(c.nome),
              );
            }).toList(),
            onChanged: (nova) {
              setState(() => costureiraSelecionada = nova);
              carregarPedidos();
            },
          ),
        ),
        if (carregando)
          const Expanded(
            child: Center(child: CircularProgressIndicator()),
          )
        else
          Expanded(
            child: pedidos.isEmpty
                ? const Center(child: Text('Nenhum pedido finalizado sem conta.'))
                : ListView.builder(
                    itemCount: pedidos.length,
                    itemBuilder: (context, index) {
                      final pedido = pedidos[index];
                      return ListTile(
                        title: Text('Pedido #${pedido.id}'),
                        subtitle: Text('Status: ${pedido.status}'),
                      );
                    },
                  ),
          ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text('Valor Total: ${formatador.format(valorTotal)}'),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: pedidos.isEmpty ? null : gerarConta,
                child: const Text('Gerar Conta a Pagar'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
