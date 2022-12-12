using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Winform_QLNH.DAO;

namespace Winform_QLNH
{
    public partial class fAdmin : Form
    {
        public fAdmin()
        {
            InitializeComponent();
            LoadAccountList();
            LoadFoodList();
        }

        void LoadFoodList()
        {
            string query = "SELECT * FROM Food";

            dtgvFood.DataSource = DataProvider.Instance.ExecuteQuery(query);
        }
        void LoadAccountList()
        {
            string query = "EXEC USP_GetAccountByUserName @userName";

            dtgvAccount.DataSource = DataProvider.Instance.ExecuteQuery(query, new object[]{"Anh0505"} );
        }    
    }
}
