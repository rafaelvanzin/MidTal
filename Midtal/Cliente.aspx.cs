using Microsoft.AspNet.Identity;
using System;
using System.Linq;
using System.Web.UI;
using Midtal;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Security.Cryptography;
using System.Net;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using System.Web.UI.WebControls;


public partial class Account_Register : Page
{

    protected void CreateUser_Click(object sender, EventArgs e)
    {

        

        string CPF_CNPJ_Banco = "" , CEP_Banco ="";
       
        CPF_CNPJ_Banco = CPF_CNPJ.Text.Replace("/", "");
        CPF_CNPJ_Banco = CPF_CNPJ_Banco.Replace("-", "");
        CPF_CNPJ_Banco = CPF_CNPJ_Banco.Replace(".", "");
        CEP_Banco = CEP.Text.Replace("-", "");
        Criptografia encrypter = new Criptografia();

        string hashEmail, hashSenha, criptoCpf_Cnpj;
        criptoCpf_Cnpj = encrypter.Encrypt(CPF_CNPJ_Banco);
        
        hashEmail = Criptografia.getMD5Hash(Email.Text);
        hashSenha = Criptografia.getMD5Hash(Senha.Text);
        
       
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MidtalDb"].ConnectionString);
        try
        {
            con.Open();
        }
        catch (Exception)
        {

            throw;
        }

        SqlCommand cmd = new SqlCommand("Insert into Usuario(Cpf_Cnpj,Nome_Razao_Social,CEP,Logradouro,Bairro,Numero,Email,Senha,Cod_Tipo_Usuario,Cidade,Sistema_Instalado,Exibicoes_Restantes,Data_Criacao)values(@Cpf_Cnpj,@Nome_Razao_Social,@CEP,@Logradouro,@Bairro,@Numero,@Email,@Senha,@Cod_Tipo_Usuario,@Cidade,@Sistema_Instalado,@Exibicoes_Restantes,@Data_Criacao)", con);
        cmd.Parameters.AddWithValue("@Cpf_Cnpj ",criptoCpf_Cnpj );
        cmd.Parameters.AddWithValue("@Nome_Razao_Social", Nome_Razao_Social.Text);
        cmd.Parameters.AddWithValue("@CEP", CEP_Banco);
        cmd.Parameters.AddWithValue("@Logradouro",Logradouro.Text);
        cmd.Parameters.AddWithValue("@Bairro", Bairro.Text);
        cmd.Parameters.AddWithValue("@Numero", Numero.Text);      
       
        cmd.Parameters.AddWithValue("@Email", hashEmail);
        cmd.Parameters.AddWithValue("@Senha", hashSenha);
        cmd.Parameters.AddWithValue("@Cod_Tipo_Usuario", Tipo.SelectedValue);
        cmd.Parameters.AddWithValue("@Cidade", Cidade.Text);
        cmd.Parameters.AddWithValue("@Sistema_Instalado", 0);
        cmd.Parameters.AddWithValue("@Exibicoes_Restantes", 0);
        cmd.Parameters.AddWithValue("@Data_Criacao", DateTime.Now);
        cmd.ExecuteNonQuery();
        con.Close();
        if (Tipo.SelectedValue.Equals("3"))
        {
            Response.Redirect("ClienteComplemento.aspx");
        }
        else
        {
            Response.Redirect("Login.aspx");
        }          

        /*
         var user = new ApplicationUser() { UserName = UserName.Text };
         IdentityResult result = manager.Create(user, Password.Text);
         if (result.Succeeded)
         {
             IdentityHelper.SignIn(manager, user, isPersistent: false);
             IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
         }
         else
         {
             ErrorMessage.Text = result.Errors.FirstOrDefault();
         }
         */
       
    }
    protected void CleanAll_Click(object sender, EventArgs e)
    {
        CPF_CNPJ.Text = null;
        Nome_Razao_Social.Text = null;
        CEP.Text = null;
        Logradouro.Text = null;
        Bairro.Text = null;
        Numero.Text = null;
        Email.Text = null;
        Senha.Text = null;
        Cidade.Text = null;
        Tipo.SelectedIndex = 0;
    }
    protected void CEP_Click(object sender, EventArgs e)
    {

        if (CEP.Text.Length == 9)
        {
            string cepSemMascara = CEP.Text.Replace("-","");
            WebClient wc = new WebClient();
            wc.Proxy = null;

            WebRequest.DefaultWebProxy = null;
            System.Net.WebRequest req = System.Net.WebRequest.Create("http://cep.correiocontrol.com.br/" + cepSemMascara + ".json");
            req.Timeout = 10000;
            System.Net.WebResponse resp = req.GetResponse();
            byte[] buffer = new byte[200];
            System.IO.StreamReader stream = new System.IO.StreamReader(resp.GetResponseStream());
            string recebedor = stream.ReadToEnd();
            recebedor = recebedor.Replace(":", "");
            recebedor = recebedor.Replace("{", "");
            recebedor = recebedor.Replace("}", "");
            recebedor = recebedor.Replace("" + '"', "");
            string[] recebeCampos;
            recebeCampos = recebedor.Split(',');

            recebeCampos[0] = recebeCampos[0].Replace("bairro ", "");
            recebeCampos[1] = recebeCampos[1].Replace("logradouro ", "");
            recebeCampos[4] = recebeCampos[4].Replace("localidade ", "");
            Bairro.Text = recebeCampos[0];
            Logradouro.Text = recebeCampos[1].TrimStart();
            Cidade.Text = recebeCampos[4].Trim();


        }

        
    }
 

   protected void Page_Load(object sender, EventArgs e)
    {

        Senha.Attributes.Add("onFocus", "pwdStr()");
        Senha.Attributes.Add("onBlur", "removeBarra()");
       
    }

   protected void Senha_TextChanged(object sender, EventArgs e)
   {
       Senha.Attributes["value"] = Senha.Text;
        Validate("validaSenha");
        if (!Page.IsValid)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "showMyDialog();", true);
        }
        
   }

   

   

   
   
   

}