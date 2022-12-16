using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Winform_QLNH.DTO;

namespace Winform_QLNH.DAO
{
    internal class CategoryDAO
    {
        private static CategoryDAO instance;

        internal static CategoryDAO Instance 
        { 
            get
            {
                if (instance == null) instance = new CategoryDAO();
                return CategoryDAO.instance;
            }
            set => instance = value; 
        }

        private CategoryDAO() { }

        public List<Category> GetListCategory()
        {
            List<Category> list = new List<Category>();
            string query = "SELECT * FROM FoodCategory";

            DataTable data = DataProvider.Instance.ExecuteQuery(query);

            foreach(DataRow item in data.Rows)
            {
                Category category = new Category(item);
                list.Add(category);
            }
            return list;
        }
    }
}
