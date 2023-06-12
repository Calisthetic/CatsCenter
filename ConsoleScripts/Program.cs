// See https://aka.ms/new-console-template for more information
using ConsoleScripts.Scripts;

Console.WriteLine("Hello, World!");
await DataBase.GetImagesByFolder(Console.ReadLine(), Convert.ToInt32(Console.ReadLine()));
