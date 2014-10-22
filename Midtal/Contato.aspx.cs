using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Mail;

public partial class Contato : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void mail_Send(object sender, EventArgs e)
    {

        string pGmailEmail = "midtalcompany@gmail.com";
        string pGmailPassword = "senhaComplicada@";
        string pTo = "goomypancho@hotmail.com";
        string pCc = "rodrigogomes901@hotmail.com";
        string pSubject = Tipo.SelectedValue;
        string pBody = txtEmail.InnerText;
        MailFormat pFormat = MailFormat.Text;
        string pAttachmentPath = string.Empty;

        System.Web.Mail.MailMessage myMail = new System.Web.Mail.MailMessage();
        myMail.Fields.Add
            ("http://schemas.microsoft.com/cdo/configuration/smtpserver",
                          "smtp.gmail.com");
        myMail.Fields.Add
            ("http://schemas.microsoft.com/cdo/configuration/smtpserverport",
                          "465");
        myMail.Fields.Add
            ("http://schemas.microsoft.com/cdo/configuration/sendusing",
                          "2");

        myMail.Fields.Add
        ("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate", "1");
        //Use 0 for anonymous
        myMail.Fields.Add
        ("http://schemas.microsoft.com/cdo/configuration/sendusername",
            pGmailEmail);
        myMail.Fields.Add
        ("http://schemas.microsoft.com/cdo/configuration/sendpassword",
             pGmailPassword);
        myMail.Fields.Add
        ("http://schemas.microsoft.com/cdo/configuration/smtpusessl",
             "true");
        myMail.From = pGmailEmail;
        myMail.To = pTo;
        myMail.Cc = pCc;
        myMail.Subject = pSubject;
        myMail.BodyFormat = pFormat;
        myMail.Body = pBody;
        if (pAttachmentPath.Trim() != "")
        {
            MailAttachment MyAttachment =
                    new MailAttachment(pAttachmentPath);
            myMail.Attachments.Add(MyAttachment);
            myMail.Priority = System.Web.Mail.MailPriority.High;
        }
        
        SmtpMail.SmtpServer = "smtp.gmail.com:587";
        SmtpMail.Send(myMail);

        //Response.("E-mail enviado com sucesso!");
    }
}