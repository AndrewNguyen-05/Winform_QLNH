using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Winform_QLNH.DTO;

namespace Winform_QLNH.DAO
{
    internal class FoodDAO
    {
        private static FoodDAO instance;

        internal static FoodDAO Instance 
        { 
            get
            {
                if(instance == null) instance = new FoodDAO();
                return FoodDAO.instance;
            }
            set => instance = value; 
        }

        private FoodDAO() { }

        public List<Food> GetListFood(int id)
        {
            List<Food> list = new List<Food>();
            string query = "SELECT * FROM Food WHERE idCategory = " + id;
            DataTable data = DataProvider.Instance.ExecuteQuery(query);

            foreach (DataRow item in data.Rows)
            {
                Food food = new Food(item);
                list.Add(food);
            }

            return list;
        }
    }
}
