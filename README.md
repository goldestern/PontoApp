# PontoApp

PontoApp e um aplicativo SwiftUI para registrar ponto no iPhone e no Apple Watch. Ele permite marcar entrada, inicio de pausa, volta da pausa e saida, mantendo um historico local e sincronizando registros entre os dispositivos.

## Funcionalidades no iPhone

- Dashboard principal com o estado atual do expediente: fora do expediente, trabalhando, em pausa ou expediente encerrado.
- Botoes contextuais para registrar apenas as acoes validas no momento, como entrada, pausa, retorno ou saida.
- Resumo do dia com total trabalhado, tempo em pausa, primeira entrada e ultima saida.
- Historico do dia com horario, tipo de batida e origem do registro.
- Tela de historico completa, agrupada por dia.
- Opcoes para apagar os registros do dia ou todo o historico local.

## Funcionalidades no Apple Watch

- Interface compacta para registrar ponto rapidamente no pulso.
- Exibicao do estado atual do expediente.
- Botoes contextuais para entrada, pausa, retorno e saida.
- Resumo rapido das horas trabalhadas no dia.
- Lista curta com as batidas mais recentes do dia.

## Sincronizacao

O app usa `WatchConnectivity` para sincronizar os registros entre iPhone e Apple Watch. Quando uma batida e feita em um dispositivo, o historico e enviado para o outro quando houver conexao disponivel.

As exclusoes tambem sao sincronizadas por meio de marcadores internos, evitando que registros apagados voltem a aparecer depois de uma sincronizacao tardia.

## Armazenamento

Os dados sao salvos localmente usando `UserDefaults`, codificados em JSON. O app nao depende de servidor externo para funcionar.

## Requisitos

- iOS 17 ou superior.
- watchOS 10 ou superior.
- Xcode em um macOS para compilar e instalar.

## Como abrir no Xcode

1. Abra `PontoApp.xcodeproj`.
2. Selecione o target `Ponto`.
3. Configure seu time em `Signing & Capabilities`.
4. Rode no simulador de iPhone ou em um iPhone pareado com Apple Watch.
