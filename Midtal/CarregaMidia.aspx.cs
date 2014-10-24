﻿using AjaxControlToolkit;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using Midtal;
using MediaInfoLib;
using MediaInfoDotNet;
using System.Web.Services;


public partial class CarregaMidia : System.Web.UI.Page
{

    int ImagemTamanhoMaximo = 1200000;
    SqlConnection conn = null;
    SqlCommand cmd = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)BindUsers();
    }
  
    protected void fileUploadCompleted(object sender, AsyncFileUploadEventArgs e)
    {
        string filename = System.IO.Path.GetFileName(AsyncFileUpload1.FileName);
              
        
        //AsyncFileUpload1.SaveAs(File.Create("c:/temp") + filename);
        //AsyncFileUpload1.SaveAs(Server.MapPath("c:/") + filename);
        string filePath = Request.PhysicalApplicationPath + AsyncFileUpload1.FileName;
        AsyncFileUpload1.SaveAs(filePath);
        
        try
        {
            // abre a conexão
            AbrirConexao();
            // cria um comando 
            CriarComando();
            // cria uma tabela se não existir
            CriarTabelaImagem();
            // prepara a inclusão da imagem
            PrepararInclusaoImagem();
            string caminhoArquivo = Path.GetDirectoryName(filePath);
            string nomeArquivo = Path.GetFileName(filePath);
            //inclui a imagem na tabela]
            string[] recebedor;
            recebedor = nomeArquivo.Split('.');
            MediaFile uploadedFile;
            if (recebedor[1].Equals("mp4"))
            {
                uploadedFile = new MediaFile(filePath);
                ExecutarInclusaoImagem(nomeArquivo, caminhoArquivo, (Usuario)Session["usuariologado"], uploadedFile.duration, exibPropria.Checked);
            }
            else
            {
                ExecutarInclusaoImagem(nomeArquivo, caminhoArquivo, (Usuario)Session["usuariologado"], 5000, exibPropria.Checked);
            
            }

            //MessageBox.Show("Imagem Incluída na tabela com sucesso !", "Imagem", MessageBoxButtons.OK, MessageBoxIcon.Information);
        }
        catch (SqlException ex)
        {
            // MessageBox.Show(ex.ToString());
        }
        finally
        {
            FecharConexao();
        }


    }
    static string GetStringConexaoPorNome(string nome)
    {
        //define a variável
        string retorno = null;
        string _chulipaNoRafa = null;
        // Procura pelo nome na seção  connectionStrings do app.config
        ConnectionStringSettings settings =
            ConfigurationManager.ConnectionStrings[nome];
        // se achou retorna a string de conexçao
        if (settings != null)
            retorno = settings.ConnectionString;
        return retorno;
    }

    /// <summary>
    /// Abre uma conexão SQL Server
    /// </summary>
    public void AbrirConexao()
    {
        try
        {
            // cria a conexão
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MidtalDb"].ConnectionString);
            // abre a conexão
            conn.Open();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    /// <summary>
    /// Fecha a conexão
    /// </summary>
    public void FecharConexao()
    {
        try
        {
            // fecha a conexão
            conn.Close();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    /// <summary>
    /// Cria um objeto command
    /// </summary>
    public void CriarComando()
    {
        try
        {
            cmd = new SqlCommand();
            cmd.Connection = conn;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    /// <summary>
    /// Executa o command
    /// </summary>
    /// <param name="cmdText"></param>
    public void ExecutarComando(string cmdTexto)
    {
        try
        {
            int cmdResultado;
            cmd.CommandText = cmdTexto;
            cmdResultado = cmd.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    /// <summary>
    /// Cria uma tabela para as imagens
    /// </summary>
    public void CriarTabelaImagem()
    {
        //verifica se a tabela Imagens existe antes de criar
        try
        {
            if (!TabelaExiste("Midia", conn.ConnectionString)) ;
            //ExecutarComando(@"create table Imagensxy(nome nvarchar(100),Midia varbinary(max))");
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    /// <summary>
    /// Prepara a inclusão das imagens na tabela
    /// </summary>
    public void PrepararInclusaoImagem()
    {
        //cria o comando sql para incluir as imagens na tabela
        try
        {

            cmd.CommandText = @"insert into Midia values (@Desc_Midia,@Cpf_Cnpj,@Cod_Usuario,@Exibicao_Propria,@Tipo_Arquivo,@Tempo_Execucao,@Midia)";
            cmd.Parameters.Add("@Desc_Midia", SqlDbType.NVarChar, 100);
            cmd.Parameters.Add("@Cpf_Cnpj", SqlDbType.VarChar, 100);
            cmd.Parameters.Add("@Cod_Usuario", SqlDbType.Int);
            cmd.Parameters.Add("@Exibicao_Propria", SqlDbType.SmallInt);
            cmd.Parameters.Add("@Tipo_Arquivo", SqlDbType.VarChar, 10);
            cmd.Parameters.Add("@Tempo_Execucao", SqlDbType.Time, 7);
            cmd.Parameters.Add("@Midia", SqlDbType.Image, 1200000);
            cmd.Prepare();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    /// <summary>
    /// Executa a inclusão da imagem na tabela
    /// </summary>
    /// <param name="imageFileNumber"></param>
    public void ExecutarInclusaoImagem(string nomeArquivo, string caminhoArquivo, Usuario usu, int duration, bool exibicaoPro)
    {
        try
        {
            byte[] imagemDados = null;
            imagemDados = CarregarArquivoImagem(nomeArquivo, caminhoArquivo, ImagemTamanhoMaximo);
            string[] recebedor;
            recebedor = nomeArquivo.Split('.');

            cmd.Parameters["@Desc_Midia"].Value = recebedor[0];
            cmd.Parameters["@Cpf_Cnpj"].Value = usu.Cpf_Cnpj;
            cmd.Parameters["@Cod_Usuario"].Value = usu.Cod_Usuario;
            if(exibicaoPro)cmd.Parameters["@Exibicao_Propria"].Value = 1;
            else cmd.Parameters["@Exibicao_Propria"].Value = 0;
            cmd.Parameters["@Tipo_Arquivo"].Value = recebedor[1];
            cmd.Parameters["@Tempo_Execucao"].Value = TimeSpan.FromMilliseconds(duration);
            cmd.Parameters["@Midia"].Value = imagemDados;
            ExecutarComando(cmd.CommandText);
            Tipo_lostFocus();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    /// <summary>
    ///  carrega a imagem 
    /// </summary>
    /// <param name="nomeArquivo"></param>
    /// <param name="caminhoArquivo"></param>
    /// <param name="ImagemTamanhoMaximo"></param>
    /// <returns></returns>
    byte[] CarregarArquivoImagem(string nomeArquivo, string caminhoArquivo, int ImagemTamanhoMaximo)
    {
        try
        {
            byte[] imagemBytes = null;
            string caminhoCompletoImagem = caminhoArquivo + "\\" + nomeArquivo;
            FileStream fs = new FileStream(caminhoCompletoImagem, FileMode.Open, FileAccess.Read);
            BinaryReader br = new BinaryReader(fs);
            imagemBytes = br.ReadBytes(ImagemTamanhoMaximo);
            return imagemBytes;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    /// <summary>
    /// Verifica se a tabela ja existe no SQL Server
    /// </summary>
    /// <param name="NomeTabela"></param>
    /// <param name="strConnection"></param>
    /// <returns></returns>
    public bool TabelaExiste(string NomeTabela, string strConnection)
    {
        using (SqlConnection conexaoSQL = new SqlConnection(strConnection))
        {
            string verificaTabela =
               String.Format(
                  "IF OBJECT_ID('{0}', 'U') IS NOT NULL SELECT 'true' ELSE SELECT 'false'",
                  NomeTabela);
            SqlCommand command = new SqlCommand(verificaTabela, conexaoSQL);
            command.CommandType = CommandType.Text;
            try
            {
                conexaoSQL.Open();
                Boolean retorno = Convert.ToBoolean(command.ExecuteScalar());
                return retorno;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
    
    public void BindUsers()
    {
        DataTable dt = GetUsersForModeration();
        GridViewMidias.DataSource = dt;
        GridViewMidias.DataBind();
    }
    public DataTable GetUsersForModeration()
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MidtalDb"].ConnectionString);
        con.Open();
        Usuario usu = (Usuario) Session["usuariologado"];
        SqlCommand com = new SqlCommand("select * from midia where Cod_Usuario =" + usu.Cod_Usuario + "and exibicao_propria = 0", con);
        DataSet ds = new DataSet();
        SqlDataAdapter ada = new SqlDataAdapter(com);
        ada.Fill(ds);
        return ds.Tables[0];
    }
    public DataTable GetUsersForModerationEP()
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MidtalDb"].ConnectionString);
        con.Open();
        Usuario usu = (Usuario)Session["usuariologado"];
        SqlCommand com = new SqlCommand("select * from midia where Cod_Usuario =" + usu.Cod_Usuario + "and exibicao_propria = 1", con);
        DataSet ds = new DataSet();
        SqlDataAdapter ada = new SqlDataAdapter(com);
        ada.Fill(ds);
        
        return ds.Tables[0];
    }
    protected void Tipo_SelectedIndexChanged(object sender, EventArgs e)
    {
       if (TipoDeMidia.SelectedIndex == 0)
       {
           DataTable dt = GetUsersForModeration();
           GridViewMidias.DataSource = dt;
       }
       else{
           if (TipoDeMidia.SelectedIndex == 1)
           {
               DataTable dt = GetUsersForModerationEP();
               GridViewMidias.DataSource = dt;          
           }
       
       }
       GridViewMidias.DataBind();
  
    }
    protected void Tipo_lostFocus() 
    {
        if (TipoDeMidia.SelectedIndex == 0)
        {
            DataTable dt = GetUsersForModeration();
            GridViewMidias.DataSource = dt;
        }
        else
        {
            if (TipoDeMidia.SelectedIndex == 1)
            {
                DataTable dt = GetUsersForModerationEP();
                GridViewMidias.DataSource = dt;

            }

        }
        GridViewMidias.DataBind();
       
    }

    protected void GridViewMidias_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string key = GridViewMidias.DataKeys[e.Row.RowIndex].Value.ToString();
            e.Row.Attributes.Add("id", key);
        }
        ScriptManager.RegisterStartupScript(Page, typeof(Page), "Grid", "selecionaGrid();", true);
    
    }
    protected void visualizar_Click(object sender, EventArgs e)
    {
        string filePath = @"c:\Temp\";
        //System.Byte teste;
        //teste = Byte.Parse(hdnMidia.Text);
        StreamWriter writer = new StreamWriter(filePath+"nome.mp4",true);
        videoStreamer.Attributes["src"] = filePath + "nome.mp4";
       ScriptManager.RegisterStartupScript(Page, typeof(Page), "Pop", "openModal();", true);

       //SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MidtalDb"].ConnectionString);
       //con.Open();

       //SqlCommand cmd = new SqlCommand("SELECT midia FROM  midia where Cod_Midia =" + hdnCodMidia.Text, con);
       //SqlDataReader dataReader = null;
       //dataReader = cmd.ExecuteReader();
       //byte[] VideoByte = new byte[1];
       //while (dataReader.Read())
       //{

       //    if (dataReader["midia"] != DBNull.Value)
       //    {
       //        VideoByte = (byte[])dataReader["midia"];
       //    }

       //}
       //Response.AppendHeader("Content-Type", "video/mp4");
       //Response.AppendHeader("Content-Length", VideoByte.Length.ToString());
       //Response.BinaryWrite(VideoByte);
       //Response.Flush();
       //Response.End();
       //con.Close();
    }

    protected void GridViewMidias_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

}