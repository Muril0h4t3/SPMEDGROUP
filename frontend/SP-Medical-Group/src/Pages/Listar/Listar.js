import React, { Component } from 'react';
// import logo from '../../logo.svg';
import '../../assets/css/App.css';
import Cabecalho from '../../Components/NavBar';

class App extends Component {
    render() {
      return (
          <div className="Listar">
          <Cabecalho/>
          <header className="App-header">
            <h1>LIstar Consultas</h1>
          </header>
          <main>
            <table id="Tabela-consulta">
            <tr>
              <th>Paciente</th>
              <th>Clinica</th>
              <th>Horário</th>
              <th>Médico</th>
            </tr>
            <tbody>
              
            </tbody>
            </table>
          </main>
        </div>
      );
    }
  }
  