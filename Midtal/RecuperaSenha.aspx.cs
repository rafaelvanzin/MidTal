using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace WebApplication4
{
    public partial class RecuperaSenha : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void CreateUser_Click(object sender, EventArgs e)
        {

            if (Captcha.Text != Session["CaptchaValue"].ToString())

            {
                Response.Redirect("RecuperaSenha.aspx");
            }
            else
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

                //SqlCommand cmd = new SqlCommand(@"Select * from Usuario where Email="+Email.Text, con);
                //using (SqlDataReader reader = cmd.ExecuteReader())
                //{
                //    reader.Read()
                //    {

                //    }
                //}
            }
        }
    }
}