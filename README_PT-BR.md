# PontoApp

PontoApp é um aplicativo SwiftUI para registrar ponto no iPhone e no Apple Watch. Ele permite marcar entrada, início de pausa, volta da pausa e saída, mantendo um histórico local e sincronizando os registros entre os dispositivos.

## Funcionalidades no iPhone

- Dashboard principal com o estado atual do expediente: fora do expediente, trabalhando, em pausa ou expediente encerrado.
- Botões contextuais para registrar apenas as ações válidas no momento, como entrada, pausa, retorno ou saída.
- Resumo do dia com total trabalhado, tempo em pausa, primeira entrada e última saída.
- Histórico do dia com horário, tipo de batida e origem do registro.
- Tela de histórico completa, agrupada por dia.
- Opções para apagar os registros do dia ou todo o histórico local.

## Funcionalidades no Apple Watch

- Interface compacta para registrar ponto rapidamente no pulso.
- Exibição do estado atual do expediente.
- Botões contextuais para entrada, pausa, retorno e saída.
- Resumo rápido das horas trabalhadas no dia.
- Lista curta com as batidas mais recentes do dia.

## Sincronização

O app usa `WatchConnectivity` para sincronizar os registros entre iPhone e Apple Watch. Quando uma batida é feita em um dispositivo, o histórico é enviado para o outro quando houver conexão disponível.

As exclusões também são sincronizadas por meio de marcadores internos, evitando que registros apagados voltem a aparecer depois de uma sincronização tardia.

## Armazenamento

Os dados são salvos localmente usando `UserDefaults`, codificados em JSON. O app não depende de servidor externo para funcionar.

## Requisitos

- iOS 17 ou superior.
- watchOS 10 ou superior.
- Xcode em um macOS para compilar e instalar.

## Como abrir no Xcode

1. Abra `PontoApp.xcodeproj`.
2. Selecione o target `Ponto`.
3. Configure seu time em `Signing & Capabilities`.
4. Rode no simulador de iPhone ou em um iPhone pareado com Apple Watch.
