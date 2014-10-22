using Microsoft.AspNet.Identity;
using System;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections.Generic;
using Midtal;
using System.Web.Security;

public partial class Account_Login : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.Cookies["UserName"] != null && Request.Cookies["Password"] != null)
            {
                UserName.Text = Request.Cookies["UserName"].Value;
                Password.Attributes["value"] = Request.Cookies["Password"].Value;
                RememberMe.Checked = true;
            }
        }
    }

    protected void LogIn(object sender, EventArgs e)
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
       
        string sql = @"SELECT * FROM  Usuario";
        using (var command = new SqlCommand(sql, con))
        {

            using (var reader = command.ExecuteReader())
            {
                var listaUsuario = new List<Usuario>();
                while (reader.Read()) listaUsuario.Add(new Usuario { Cod_Usuario = reader.GetInt32(0), Cpf_Cnpj = reader.GetString(1), Nome_Razao_Social = reader.GetString(2), CEP = reader.GetInt32(3), Logradouro = reader.GetString(4), Bairro = reader.GetString(5), Numero = reader.GetInt32(6), Email = reader.GetString(7), Senha = reader.GetString(8), Tipo = reader.GetInt32(9), Cidade = reader.GetString(10), Exibicoes_Restantes = reader.GetInt32(11), Sistema_Instalado = reader.GetByte(12) });
                foreach (Usuario usu in listaUsuario)
                {

                    if (Criptografia.getMD5Hash(UserName.Text) == usu.Email &&
                        Criptografia.getMD5Hash(Password.Text) == usu.Senha)
                    {
                        Session["usuariologado"] = usu;
                        if (RememberMe.Checked)
                        {
                            Response.Cookies["UserName"].Expires = DateTime.Now.AddDays(30);
                            Response.Cookies["Password"].Expires = DateTime.Now.AddDays(30);
                            
                        }
                        else
                        {
                            Response.Cookies["UserName"].Expires = DateTime.Now.AddDays(-1);
                            Response.Cookies["Password"].Expires = DateTime.Now.AddDays(-1);

                        }
                        Response.Cookies["UserName"].Value = UserName.Text.Trim();
                        Response.Cookies["Password"].Value = Password.Text.Trim();
                        if (usu.Tipo == 3 && usu.Sistema_Instalado == 0) Response.Redirect("Bloqueio.aspx");
                        else Response.Redirect("Default.aspx");
                        break;
                    }
                }

            }
            con.Close();
        }

    }
}