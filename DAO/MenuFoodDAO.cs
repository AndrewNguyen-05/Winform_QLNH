using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Winform_QLNH.DTO;

namespace Winform_QLNH.DAO
{
    internal class MenuFoodDAO
    {
        private static MenuFoodDAO instance;

        internal static MenuFoodDAO Instance 
        {
            get
            {
                if(instance == null) instance = new MenuFoodDAO();
                return MenuFoodDAO.instance;
            }
            set => instance = value; 
        }
        private MenuFoodDAO() { }

        public List<MenuFood> GetListMenuByTable(int id)
        {
            List<MenuFood> listMenu = new List<MenuFood>();

            string query = "SELECT f.name, bi.count, f.price, f.price * bi.count AS totalPrice FROM BillInfo bi, Bill b, Food f WHERE bi.idBill = b.id AND bi.idFood = f.id AND b.status = 0 AND b.idTable = " + id;
            DataTable data = DataProvider.Instance.ExecuteQuery(query);

            foreach(DataRow item in data.Rows)
            {
                MenuFood menu = new MenuFood(item);
                listMenu.Add(menu);
            }
            return listMenu;
        }
    }
}
