using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace Midtal
{
    public class Criptografia
    {
        private readonly TripleDESCryptoServiceProvider _des = new TripleDESCryptoServiceProvider();
        private readonly UTF8Encoding _utf8 = new UTF8Encoding();
        private byte[] _keyValue;
        private byte[] _ivValue;
        public Criptografia()
        {

            System.Configuration.AppSettingsReader settingsReader =
                                      new AppSettingsReader();
            string key = (string)settingsReader.GetValue("SecurityKey",
                                                 typeof(String));
            string vector = (string)settingsReader.GetValue("SecurityVector",
                                                     typeof(String));
            _keyValue = Convert.FromBase64String(key);
            _ivValue = Convert.FromBase64String(vector);
        }

        public byte[] Key
        {
            get { return _keyValue; }
            private set { _keyValue = value; }
        }
        public byte[] IV
        {
            get { return _ivValue; }
            private set { _ivValue = value; }
        }
        private byte[] Transform(byte[] input, ICryptoTransform cryptoTransform)
        {
            // Create the necessary streams
            using (var memory = new MemoryStream())
            {
                using (var stream = new CryptoStream(memory, cryptoTransform, CryptoStreamMode.Write))
                {
                    // Transform the bytes as requested
                    stream.Write(input, 0, input.Length);
                    stream.FlushFinalBlock();

                    // Read the memory stream and convert it back into byte array
                    memory.Position = 0;
                    var result = new byte[memory.Length];
                    memory.Read(result, 0, result.Length);

                    // Return result
                    return result;
                }
            }
        }

        public byte[] Encrypt(byte[] bytes)
        {
            return Transform(bytes, _des.CreateEncryptor(_keyValue, _ivValue));
        }

        public byte[] Decrypt(byte[] bytes)
        {
            return Transform(bytes, _des.CreateDecryptor(_keyValue, _ivValue));
        }

        public string Decrypt(string text)
        {
            byte[] input = HttpServerUtility.UrlTokenDecode(text);
            byte[] output = Transform(input, _des.CreateDecryptor(_keyValue, _ivValue));
            return _utf8.GetString(output);
        }
        public string Encrypt(string text)
        {
            byte[] input = _utf8.GetBytes(text);
            byte[] output = Transform(input, _des.CreateEncryptor(_keyValue, _ivValue));
            return HttpServerUtility.UrlTokenEncode(output);
        }
        public static string CreateNewVector()
        {
            using (var des = new System.Security.Cryptography.TripleDESCryptoServiceProvider())
            {
                des.GenerateIV();
                return Convert.ToBase64String(des.IV);
            }
        }

        public static string CreateNewKey()
        {
            using (var des = new System.Security.Cryptography.TripleDESCryptoServiceProvider())
            {
                des.GenerateKey();
                return Convert.ToBase64String(des.Key);
            }
        }
        public static string getMD5Hash(string input)
        {

            System.Security.Cryptography.MD5 md5 = System.Security.Cryptography.MD5.Create();

            byte[] inputBytes = System.Text.Encoding.ASCII.GetBytes(input);

            byte[] hash = md5.ComputeHash(inputBytes);

            System.Text.StringBuilder sb = new System.Text.StringBuilder();

            for (int i = 0; i < hash.Length; i++)
            {

                sb.Append(hash[i].ToString("X2"));

            }
            return sb.ToString();

        }

       
    }
}