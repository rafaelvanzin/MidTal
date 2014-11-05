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

            if (!this.IsPostBack)
            {
                this.AtualizaHistorico();
            }    
        }

        private void AtualizaHistorico()
        {
            this.grdHistorico.DataSource = this.GetHistoricoCompras();
            this.grdHistorico.DataBind();
        }
    
        protected void compra_Click(object sender, EventArgs e)
        {
            if (Session["usuariologado"] != null)
            {
                Usuario usu = (Usuario)(Session["usuariologado"]);
                int qtde = 0;
                decimal valor = 0;

                if (radioCompra.SelectedValue.Equals("0"))
                {
                    qtde = 100;
                    valor = 50;
                }
                else if (radioCompra.SelectedValue.Equals("1"))
                {
                    qtde = 500;
                    valor = 200;
                }
                else if (radioCompra.SelectedValue.Equals("2"))
                {
                    qtde = 1000;
                    valor = 400;
                }
                else if (radioCompra.SelectedValue.Equals("3"))
                {
                    qtde = 3000;
                    valor = 1000;
                }


                //Tratamento para a chamada do PagSeguro
                PaymentRequest payment = new PaymentRequest();
                payment.Items.Add(new Item("0001", "Pacote de Exibições", qtde, valor));
                payment.Sender = new Sender(usu.Nome_Razao_Social,usu.Email,new Phone("54","30254370"));

                //Endereço de envio
                payment.Shipping = new Shipping();
                payment.Shipping.ShippingType = ShippingType.Sedex;

                payment.Shipping.Address = new Address("BRA", "RS", usu.Cidade, usu.Bairro, usu.CEP.ToString(), usu.Logradouro, usu.Numero.ToString(), "");
                payment.Currency = Currency.Brl;
                payment.Reference = "001";
                payment.RedirectUri = this.Request.Url;
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
               
                
                cmd.Parameters.AddWithValue("@Valor", valor);
                cmd.Parameters.AddWithValue("@Qtde_Exibicoes", qtde);
                cmd.ExecuteNonQuery();
                con.Close();

                Response.Redirect(paymentRedirectUri.AbsoluteUri);  
            }
        }

        protected void historico_Click(object sender, EventArgs e)
        {
            //this.grdHistorico.DataSource = GetHistoricoCompras();
            //this.grdHistorico.DataBind();
            //
            ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "$('#PopupHistorico').show();", true);
        }

        public DataTable GetHistoricoCompras()
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MidtalDb"].ConnectionString);
            con.Open();
            Usuario usu = (Usuario)Session["usuariologado"];
            SqlCommand com = new SqlCommand("select compra.*, case when status = 0 then 'Aguardando Liberação' when status = 1 then 'Liberado' end as situacao from compra where Cod_Usuario =" + usu.Cod_Usuario + "order by data_hora desc", con);
            DataSet ds = new DataSet();
            SqlDataAdapter ada = new SqlDataAdapter(com);
            ada.Fill(ds);

            return ds.Tables[0];
        }
    }
}