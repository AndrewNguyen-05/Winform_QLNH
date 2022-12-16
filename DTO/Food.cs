using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Security.Policy;
using System.Text;
using System.Threading.Tasks;

namespace Winform_QLNH.DTO
{
    internal class Food
    {
        public Food(int id, string name, int categoryid, float price)
        {
            this.ID = id;
            this.Name = name;
            this.CategoryID = categoryid;
            this.Price = price;
        }

        public Food(DataRow row)
        {
            this.ID = (int)row["id"];
            this.Name = row["name"].ToString();
            this.categoryID = (int)row["idCategory"];
            this.Price = (float)Convert.ToDouble(row["price"].ToString());
        }
        private int iD;
        public int ID { get; set; }

        private string name;
        public string Name { get; set; }

        private int categoryID;
        public int CategoryID { get; set; }

        private float price;
        public float Price { get; set; }
    }
}
