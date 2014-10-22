using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Midtal;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Midtal
{
    class NovaCompra
    {
        private int _Cod_Compra;
        private int _Cod_Usuario;
        private string _Cpf_Cnpj;
        private short _Status;
        private DateTime _Data_Hora;
        private double _Valor;
        private int _Qte_Exibicoes;

        public int Cod_Compra
        {
            get { return _Cod_Compra; }
            set { _Cod_Compra = value; }
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
        public short Status
        {
            get { return _Status; }
            set { _Status = value; }
        }
        public DateTime Data_Hora
        {
            get { return _Data_Hora; }
            set { _Data_Hora = value; }
        }
        public double Valor
        {
            get { return _Valor; }
            set { _Valor = value; }
        }
        public int Qte_Exibicoes
        {
            get { return _Qte_Exibicoes; }
            set { _Qte_Exibicoes = value; }
        }


        public void bought(object sender, double Valor_Compra,int Qte_Exibicoes,Usuario usu, EventArgs e)
        {
           
                
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MidtalDb"].ConnectionString);
                try
                {
                    con.Open();
                }
                catch (Exception)
                {

                    throw;
                }
                DateTime now = DateTime.Now;
                SqlCommand cmd = new SqlCommand("Insert into Compras(Cod_Usuario,Cpf_Cnpj,Status,Data_Hora,Valor,Qte_Exibicoes) values(@Cod_Usuario,@Cpf_Cnpj,@Status,@Data_Hora,@Valor,@Qte_Exibicoes)", con);
                cmd.Parameters.AddWithValue("@Cod_Usuario", usu.Cod_Usuario);
                cmd.Parameters.AddWithValue("@Cpf_Cnpj", usu.Cpf_Cnpj);
                cmd.Parameters.AddWithValue("@Status", 0);
                cmd.Parameters.AddWithValue("@Data_Hora",now);
                double valorTotalTemp = Valor_Compra;
               
                if(valorTotalTemp==500.0){
                   valorTotalTemp *= 1.2;
                }
                else{
                    if(valorTotalTemp==1000)valorTotalTemp *= 0.6;                        
                    else valorTotalTemp = valorTotalTemp*2;

                        
                }

                cmd.Parameters.Add("@Valor", valorTotalTemp);
                cmd.Parameters.AddWithValue("@Qte_Exibicoes", Qte_Exibicoes);
                cmd.ExecuteNonQuery();
                con.Close();
                
            }
    }

}
