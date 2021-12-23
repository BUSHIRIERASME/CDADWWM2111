﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Evaluation
{
    public class PascalTriangle
    {
        /// <summary>
        /// Display the 10 first rows of Pascal Triangle
        /// </summary>
        public void DisplayTenFirstPascalRows() 
        {
            const int rows = 10;
            int[][] triangle = new int[rows][];

            // Parcourir toutes les lignes de notre triangle.
            for (var i = 0; i < rows; i++)
            {
                triangle[i] = new int[i + 1];
                // Parcourir toutes les colonnes de la ligne i du triangle.
                for (var j = 0; j < i+1; j++)
                {
                    // Si première ou dernière valeur de la ligne i alors valeur = 1
                    if (j == 0 ||j == i)
                    {
                        triangle[i][j] = 1;
                    }
                    else
                    {
                        triangle[i][j] = triangle[i - 1][j - 1] + triangle[i - 1][j];
                    }

                    Console.Write($"{triangle[i][j]} ");
                }
                Console.Write(Environment.NewLine);
            }
        }

        /// <summary>
        /// Get the nth line in Pascal Triangle (n starts at 0)
        /// </summary>
        /// <param name="n">nth line to return</param>
        /// <returns>The nth line in Pascal Triangle</returns>
        public int[] GetNthPascalLine(int n)
        {
            int[] result = new int[n + 1];
            
            // Base case
            if (n == 0)
            {
                return new int[] { 1 };
            }
            else
            {
                int[] previousPascalLine = GetNthPascalLine(n - 1);

                for (var i = 0; i < result.Length; i++)
                {
                    if (i == 0 || i == result.Length - 1)
                    {
                        result[i] = 1;
                    }
                    else
                    {
                        result[i] = previousPascalLine[i - 1] + previousPascalLine[i];
                    }
                }
                return result;
            }
        }

        /// <summary>
        /// Display the nth line in Pascal Triangle (n starts at 0)
        /// </summary>
        /// <param name="n">nth line to display</param>
        /// <returns>null</returns>
        public int? DisplayNthPascalineLine(int n)
        {
            int[] line = GetNthPascalLine(n);
            foreach(int value in line)
            {
                Console.Write($"{value} ");
            }
            Console.Write(Environment.NewLine);
            return null;
        }
    }
}
