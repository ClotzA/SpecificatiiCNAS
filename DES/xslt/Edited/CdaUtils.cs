using System.IO;
using System.Xml;
using System.Xml.XPath;
using System.Xml.Xsl;

namespace Des.Utils
{
  public static class CdaUtils
  {
    public static string ApplyTransformToHtml(string cdaFilePath, string xslFilePath = null)
    {
      using (FileStream fileStream = new FileStream(cdaFilePath, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
        return ApplyTransformToHtml(fileStream, xslFilePath);
    }

    public static string ApplyTransformToHtml(Stream cdaStream, string xslFilePath = null)
    {
	  // reset steam position
      cdaStream.Position = 0;
	  // load XSLT
	  var compiledTransform = new XslCompiledTransform();
      compiledTransform.Load(xslFilePath ?? Settings.Default.CdaTransformXslFilePath);
	  // load XML
	  var xmlDocument = new XmlDocument();
      xmlDocument.Load(cdaStream);
	  // apply transform
      string tempFileName = Path.GetTempFileName();
      using (FileStream fileStream = File.OpenWrite(tempFileName))
        compiledTransform.Transform(xmlDocument, null, fileStream);
      return tempFileName;
    }
  }
}
