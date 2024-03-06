namespace Lez_02_09_ContenitoriSemplici
{
    internal class Program
    {
        static void Main(string[] args)
        {
            //int[] numeri = { 1, 21234, 323, 423, 5234, 623};
            //numeri[1] = 123049;
            //Console.WriteLine(numeri[]);

            int[] numeri = new int[6]; //versione esplicita
            numeri[0] = 2;
            numeri[1] = 234;
            numeri[2] = 1234;
            numeri[3] = 653;
            numeri[4] = 12;
            numeri[5] = 34;


            //int max = numeri.Length;

            //while (i<max)
            //{
            //Console.WriteLine(numeri[i]);
            //i++;
            //}

            //for(int i=0; i<max; i++)
            //{
            //    Console.WriteLine(numeri[i]);
            //}

            string[] parco = { "MASERATI", "LAMBORGHINI", "FIAT", "BMW" };

            Array.Sort(parco); //ordinamento alfabetico 

            //int max2 = parco.Length;

            //for (int i = 0; i < max2; i++)
            //{
            //    //Console.WriteLine(parco[i]);
            //}

            //string ricerca = "sos";
            //bool trovato = false;

            //for (int i = 0; i < parco.Length; i++)
            //{
            //    if (parco[i].Equals(ricerca))
            //    {
            //        trovato = true;
            //    }


            //}

            //if (trovato == true)
            //{
            //    Console.WriteLine("Trovato");
            //}
            //else
            //{
            //    Console.WriteLine("Non trovato");
            //}

            //foreach(string auto in parco)
            //{
            //    Console.WriteLine(auto);
            //}



            //presa una stringa composta in questo modo "giovanni, valeria, marika, mario, valeria." trasformarla in un array,
            //evitando ripetizioni


            string? nomi = "Giovanni,Valeria,Marika,Mario,Valeria";
            string? nome = "";
            string?[] nomiArray= new string[8];      //array non dinamico, dimensione da specificare obbligatoriamente - array nullable? - abuso nullable
            //string virgola = ",";                 //perchè non si può
            int c = 0;

            for (int i = 0; i < nomi.Length; i++)
            {
                if (nomi[i] != (',') || i == nomi.Length)
                {
                    nome += nomi[i];
                }
                else
                {
                    if (nome is not null)
                    {
                        nomiArray[c] = nome;
                        nome = null;
                        c++;
                    }
                }

            }

            nome = null;

            int x = 0;

            //for (int i = 0; i < nomiArray.Length; i++)
            //{
            //    x = i + 1;

            //while (x <= nomiArray.Length)
            //    {
            //        if (nomiArray[i] is not null && nomiArray[i] == nomiArray[x])
            //            nomiArray[x] = null;
            //    }
            //}

            for (int i = 0;i <= nomiArray.Length; i++)
            {
                Console.WriteLine(nomiArray[i]);
            }
            
            
        }
    }
}
