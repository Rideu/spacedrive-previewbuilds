using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Xml;
using System.Xml.Serialization;
using System.Threading;
using System.Threading.Tasks;
using WinD = System.Drawing;
using WinF = System.Windows.Forms;
using System.Runtime.InteropServices;
using System.IO;
using System.ComponentModel;
using System.Data;

using static System.Math;

using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Graphics;
using Microsoft.Xna.Framework.Input;
using Microsoft.Xna.Framework.Audio;
using Microsoft.Xna.Framework.Design;
using Microsoft.Xna.Framework.Content;

using static SpaceDrive.Calc;
using static SpaceDrive.Simplex;
using static SpaceDrive.Effector;

namespace SpaceDrive
{

    [XmlRoot("font")]
    public class BitmapFontFile
    {
        public BitmapFontFile()
        {

        }
        [XmlElement("info")]
        public BitmapFontInfo Info { get; set; }

        [XmlElement("common")]
        public BitmapFontCommon Common { get; set; }

        [XmlArray("pages")]
        [XmlArrayItem("page")]
        public List<BitmapFontPage> Pages { get; set; }

        [XmlArray("chars")]
        [XmlArrayItem("char")]
        public List<BitmapFontChar> Chars { get; set; }

        [XmlArray("kernings")]
        [XmlArrayItem("kerning")]
        public List<BitmapFontKerning> Kernings { get; set; }
    }

    public class BitmapFontChar
    {
        [XmlAttribute("id")]
        public int Id { get; set; }

        [XmlAttribute("x")]
        public int X { get; set; }

        [XmlAttribute("y")]
        public int Y { get; set; }

        [XmlAttribute("width")]
        public int Width { get; set; }

        [XmlAttribute("height")]
        public int Height { get; set; }

        [XmlAttribute("xoffset")]
        public int XOffset { get; set; }

        [XmlAttribute("yoffset")]
        public int YOffset { get; set; }

        [XmlAttribute("xadvance")]
        public int XAdvance { get; set; }

        [XmlAttribute("page")]
        public int Page { get; set; }

        [XmlAttribute("chnl")]
        public int Channel { get; set; }
    }

    public class BitmapFontCommon
    {
        [XmlAttribute("lineHeight")]
        public int LineHeight { get; set; }

        [XmlAttribute("base")]
        public int Base { get; set; }

        [XmlAttribute("scaleW")]
        public int ScaleW { get; set; }

        [XmlAttribute("scaleH")]
        public int ScaleH { get; set; }

        [XmlAttribute("pages")]
        public int Pages { get; set; }

        [XmlAttribute("packed")]
        public int Packed { get; set; }

        [XmlAttribute("alphaChnl")]
        public int AlphaChannel { get; set; }

        [XmlAttribute("redChnl")]
        public int RedChannel { get; set; }

        [XmlAttribute("greenChnl")]
        public int GreenChannel { get; set; }

        [XmlAttribute("blueChnl")]
        public int BlueChannel { get; set; }
    }

    public class BitmapFontPage
    {
        [XmlAttribute("id")]
        public int Id { get; set; }

        [XmlAttribute("file")]
        public string File { get; set; }
    }

    public class BitmapFontKerning
    {
        [XmlAttribute("first")]
        public int First { get; set; }

        [XmlAttribute("second")]
        public int Second { get; set; }

        [XmlAttribute("amount")]
        public int Amount { get; set; }
    }

    public class BitmapFontInfo
    {
        [XmlAttribute("face")]
        public string Face { get; set; }

        [XmlAttribute("size")]
        public int Size { get; set; }

        [XmlAttribute("bold")]
        public int Bold { get; set; }

        [XmlAttribute("italic")]
        public int Italic { get; set; }

        [XmlAttribute("charset")]
        public string CharSet { get; set; }

        [XmlAttribute("unicode")]
        public int Unicode { get; set; }

        [XmlAttribute("stretchH")]
        public int StretchHeight { get; set; }

        [XmlAttribute("smooth")]
        public int Smooth { get; set; }

        [XmlAttribute("aa")]
        public int SuperSampling { get; set; }

        [XmlAttribute("padding")]
        public string Padding { get; set; }

        [XmlAttribute("spacing")]
        public string Spacing { get; set; }

        [XmlAttribute("outline")]
        public int OutLine { get; set; }
    }
}