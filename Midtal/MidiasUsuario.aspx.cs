using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace WebApplication4
{
    public partial class MidiasUsuario : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            GridView1.DataSource = data();
            GridView1.DataBind();
        }
        public DataTable data()
        {
            DataTable Midias = new DataTable();
            Midias.Columns.Add("Mídias", typeof(string));
            Midias.Columns.Add("Extenção", typeof(string));
            Midias.Columns.Add("Tempo", typeof(string));
            Midias.Rows.Add("TESTE", "JPG", "00:00:30");
            Midias.Rows.Add("XXX", "AVI", "00:01:00");
            Midias.Rows.Add("AAA", "PPT", "00:02:30");
            Midias.Rows.Add("BBB", "TXT", "00:00:15");

            return Midias;
        }
    }
}