import './App.css';

import {
  BarElement,
  CategoryScale,
  Chart as ChartJS,
  Legend,
  LinearScale,
  Title,
  Tooltip,
} from 'chart.js';
import { useCallback, useEffect, useState } from 'react';
// import { Bar } from 'react-chartjs-2';
import useWebSocket from 'react-use-websocket';
import IResponse, { DadosValores } from './interfaces/relatorio-hub.interface';
import { Bar } from 'react-chartjs-2';
import IDataset from './interfaces/dataset.interface';

ChartJS.register(
  CategoryScale,
  LinearScale,
  BarElement,
  Title,
  Tooltip,
  Legend
);

export const options = {
  plugins: {
    title: {
      display: true,
      text: 'Projeto Conceito',
    },
  },
  responsive: true,
  scales: {
    x: {
      stacked: true,
    },
    y: {
      stacked: true,
    },
  },
};

function App() {

  const [socketUrl] = useState('ws://localhost:5000/hub');
  const [anos, setAnos] = useState<DadosValores[]>([]);

  const { sendMessage, lastMessage } = useWebSocket(socketUrl);

  const json = '{"protocol": "json","version": 1}';

  const [labels, setLabels] = useState<string[]>([]);
  const [datasets, setDatasets] = useState<IDataset[]>([]);

  const data = {
    labels,
    datasets: datasets
  };

  useEffect(() => {
    setTimeout(() => {
      sendMessage(json);
    }, 1000);
  }, []);

  useEffect(() => {

    if (lastMessage !== null) {
      const mensagemTratada = lastMessage.data.substring(0, lastMessage.data.length - 1);
      const responseObj: IResponse = JSON.parse(mensagemTratada);

      if (responseObj?.arguments) {
        const valores = responseObj.arguments;

        if (labels.length == 0)
          setLabels(Object.keys(valores[0]));

        setDatasets([{
          label: 'Total de Pessoas',
          data: Object.values(valores[0]),
          backgroundColor: 'rgb(255, 99, 132)'
        }]);
      }
    }
  }, [lastMessage]);

  return (
    <div className="main">
      <div className="grafico">
        <Bar options={options} data={data} />
      </div>
    </div>
  );
}

export default App;
