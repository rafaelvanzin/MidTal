using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Midtal;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

using System.Web.Security;
using Uol.PagSeguro.Domain;
using Uol.PagSeguro.Constants;



namespace Midtal
{
    public partial class Compras : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuariologado"] == null)
            {
                FormsAuthentication.RedirectToLoginPage();
            }
            

        }
     
        protected void compra_Click(object sender, EventArgs e)
        {
            if (Session["usuariologado"] != null)
            {
                Usuario usu = (Usuario)(Session["usuariologado"]);

                //Tratamento para a chamada do PagSeguro
                PaymentRequest payment = new PaymentRequest();
                payment.Items.Add(new Item("0001", "Pacote de Exibições", int.Parse(spnQuantidade.Value), 1.00m));
                payment.Sender = new Sender(usu.Nome_Razao_Social,usu.Email,new Phone("54","30254370"));

                //Endereço de envio
                payment.Shipping = new Shipping();
                payment.Shipping.ShippingType = ShippingType.Sedex;

                payment.Shipping.Address = new Address("BRA", "RS", usu.Cidade, usu.Bairro, usu.CEP.ToString(), usu.Logradouro, usu.Numero.ToString(), "");
                payment.Currency = Currency.Brl;
                payment.Reference = "001";
                payment.RedirectUri = new Uri("http://google.com");
                AccountCredentials credentials = Uol.PagSeguro.Resources.PagSeguroConfiguration.Credentials(true);
                Uri paymentRedirectUri = payment.Register(credentials);


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
                SqlCommand cmd = new SqlCommand("Insert into Compra(Cod_Usuario,Cpf_Cnpj,Status,Data_Hora,Valor,Qtde_Exibicoes) values(@Cod_Usuario,@Cpf_Cnpj,@Status,@Data_Hora,@Valor,@Qtde_Exibicoes)", con);
                cmd.Parameters.AddWithValue("@Cod_Usuario", usu.Cod_Usuario);
                cmd.Parameters.AddWithValue("@Cpf_Cnpj", usu.Cpf_Cnpj);
                cmd.Parameters.AddWithValue("@Status", 0);
                cmd.Parameters.AddWithValue("@Data_Hora",now);
                double valorTotalTemp = 0;
               
                if(valorTotalTemp==500.0){
                   valorTotalTemp *= 1.2;
                   
                }
                else{
                    if (valorTotalTemp == 1000)
                    {
                        valorTotalTemp *= 0.6;
                    }
                    else
                    {
                        valorTotalTemp = valorTotalTemp * 2;
                    }

                        
                }
                
                cmd.Parameters.AddWithValue("@Valor", valorTotalTemp);
                cmd.Parameters.AddWithValue("@Qtde_Exibicoes", spnQuantidade.Value);
                cmd.ExecuteNonQuery();
                con.Close();

                Response.Redirect(paymentRedirectUri.AbsoluteUri);  
                
            }

 
        }
       
       
    }
}