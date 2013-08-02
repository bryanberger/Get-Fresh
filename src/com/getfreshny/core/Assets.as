package com.getfreshny.core
{
	public class Assets
	{

		/** ATTENTION: Naming conventions!
		 *  
		 *  - Classes for embedded IMAGES should have the exact same name as the file,
		 *    without extension. This is required so that references from XMLs (atlas, bitmap font)
		 *    won't break.
		 *    
		 *  - Atlas and Font XML files can have an arbitrary name, since they are never
		 *    referenced by file name.
		 * 
		 */
		
		[Embed(source = '/fonts/KelsonSansRegular.otf',
		fontName = "KelsonSansRegular",  
		fontStyle="regular",
		advancedAntiAliasing="true", 
		embedAsCFF="false",
		unicodeRange ='U+0020-007E',
		mimeType="application/x-font")]
		public static const KelsonSansRegular:Class;
		
		[Embed(source = '/fonts/KelsonSansBold.otf',
		fontName = "KelsonSansBold",  
		fontStyle="regular",
		advancedAntiAliasing="true", 
		embedAsCFF="false",
		unicodeRange ='U+0020-007E',
		mimeType="application/x-font")]
		public static const KelsonSansBold:Class;
		
		[Embed(source = '/fonts/PompiereRegular.otf',
		fontName = "PompiereRegular",  
		fontStyle="regular",
		advancedAntiAliasing="true", 
		embedAsCFF="false",
		unicodeRange ='U+0020-007E',
		mimeType="application/x-font")]
		public static const PompiereRegular:Class;
		
		
		// straight up bitmaps
		[Embed(source="/spritesheet.xml", mimeType="application/octet-stream")]
		public static const spritesheet_xml:Class;
		[Embed(source="/spritesheet.png"), mimeType="application/octet-stream")]
		public static const spritesheet:Class;
		
		[Embed(source="/cta1.png")]
		public static const cta1:Class;
		
		[Embed(source="/cta2.png")]
		public static const cta2:Class;
		
		[Embed(source="/cta3.png")]
		public static const cta3:Class;
		
		[Embed(source="/ctaDetail1.png")]
		public static const ctaDetail1:Class;
		
		[Embed(source="/ctaDetail2.png")]
		public static const ctaDetail2:Class;
		
		[Embed(source="/ctaDetail3.png")]
		public static const ctaDetail3:Class;
		
		[Embed(source="/juices/Juice1.png")]
		public static const juice1:Class;
		
		[Embed(source="/juices/Juice2.png")]
		public static const juice2:Class;
		
		[Embed(source="/juices/Juice3.png")]
		public static const juice3:Class;
	} // END CLASS
} // END PACKAGE