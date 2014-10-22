using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Midtal
{
    public class Usuario
    {
        private int _Cod_Usuario;
        private string _Cpf_Cnpj;
        private string _Nome_Razao_Social;
        private int _CEP;
        private string _Logradouro;
        private string _Bairro;
        private int _Numero;
        private string _Email;
        private string _Senha;
        private int _Tipo;


        private string _Cidade;
        private int _Exibicoes_Restantes;
        private short _Sistema_Instalado;


        public enum TipoUsuario
        {
            Administrador = 0,
            Anunciante = 1,
            Exibidor = 2
        }
        public int Cod_Usuario
        {
            get { return _Cod_Usuario; }
            set { _Cod_Usuario = value; }
        }
        public string Cpf_Cnpj
        {
            get { return _Cpf_Cnpj; }
            set { _Cpf_Cnpj = value; }
        }
        public string Nome_Razao_Social
        {
            get { return _Nome_Razao_Social; }
            set { _Nome_Razao_Social = value; }
        }
        public int CEP
        {
            get { return _CEP; }
            set { _CEP = value; }
        }

        public string Logradouro
        {
            get { return _Logradouro; }
            set { _Logradouro = value; }
        }
        public string Bairro
        {
            get { return _Bairro; }
            set { _Bairro = value; }
        }
        public int Numero
        {
            get { return _Numero; }
            set { _Numero = value; }
        }
        public string Email
        {
            get { return _Email; }
            set { _Email = value; }
        }
        public string Senha
        {
            get { return _Senha; }
            set { _Senha = value; }
        }
        public int Tipo
        {
            get { return _Tipo; }
            set { _Tipo = value; }
        }


        public string Cidade
        {
            get { return _Cidade; }
            set { _Cidade = value; }
        }
        public int Exibicoes_Restantes
        {
            get { return _Exibicoes_Restantes; }
            set { _Exibicoes_Restantes = value; }
        }
        public short Sistema_Instalado
        {
            get { return _Sistema_Instalado; }
            set { _Sistema_Instalado = value; }
        }
       

    }
}
