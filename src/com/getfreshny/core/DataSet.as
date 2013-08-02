package com.getfreshny.core
{
	import com.getfreshny.views.MainView;
	import com.getfreshny.vo.JuiceVO;
	
	import feathers.data.ListCollection;
	
	import starling.display.Image;

	public class DataSet
	{
		public var ingredients:Array;
		public var juices:Vector.<JuiceVO>;
		public var preparations:Array;
		public var curSelectedVO:JuiceVO;
		public var informationText:String;
		public var informationText2:String;
		public var tileListCollection:ListCollection;
		
		public function DataSet():void
		{
			ingredients = ['Strawberries', 'Raspberries', 'Blueberries'];			
			preparations = ['Made to order', 'Cold Pressed'];
			informationText = 'Fruit juices generally contain large amounts of Vitamin C which promotes healthy metabolism. Vegetable juices contain Vitamin A and E which helps with concentration and eye sight. Our fruit juice is pure and organic, it contains 100% fruit juice grown locally in NY state, its perfect for locavores, hipsters, hackers and just plain regular people. Try any one of our many juice blends, our blends are special because they contain mixtures of vegetables and fruits and can be customized to suit your preferences and based on the the seasonality of the ingredients. And a portion of every sale goes to GROWNYC which helps in distributing to New Yorkers in need of fresh market produce and foods.';
			informationText2 = 'A portion of every sale goes to GROWNYC which helps in distributing to New Yorkers in need of fresh market produce and foods.';
			
			tileListCollection = new ListCollection(
				[
					{ texture: MainView.am.getTexture('cta1') },
					{ texture: MainView.am.getTexture('cta2') },
					{ texture: MainView.am.getTexture('cta3') }
				]);
			
			juices = new Vector.<JuiceVO>();			
			juices[0] = new JuiceVO(
				1,
				'Antioxidant Pro-yum',
				'A boost of berry-blend energy when you need it most. With an added pinch of lemon.',
				'$6.99',
				6.99,
				'16oz',
				'organic raspberries, filtered ionized water, organic lemon, organic mint, organic ginger.',
				'16oz (1 bottle)',
				new Image(MainView.am.getTexture('juice1'))
			);
			
			juices[1] = new JuiceVO(
				2,
				'The Energizer',
				'Strawberry goodness! This juice contains seasonal passionfruit as well! A must have for this season.',
				'$6.99',
				6.99,
				'16oz',
				'organic strawberries, filtered ionized water, organic passionfruit.',
				'16oz (1 bottle)',
				new Image(MainView.am.getTexture('juice2'))
			);
				
			juices[2] = new JuiceVO(
				3,
				'Seeing Green',
				'This juice will change your mind about drinking coffee ever again. A slew of vitamins in this one!',
				'$8.99',
				8.99,
				'16oz',
				'kale, raspberries, filtered ionized water, organic lemon juice, green apple.',
				'16oz (1 bottle)',
				new Image(MainView.am.getTexture('juice3'))
			);
			
			juices[3] = new JuiceVO(
				1,
				"Jon's Kickin' Lemonade",
				'Lemon, orange, lime, grapefruit. A swirl of citrus goodies with a twist of raspberry puree.',
				'$7.00',
				7.00,
				'16oz',
				'organic orange, orangic raspberries, organic lemon juice, organic grapefruit, organic lime.',
				'16oz (1 bottle)',
				new Image(MainView.am.getTexture('juice1'))
			);
			
			juices[4] = new JuiceVO(
				2,
				"Poppin' Pomegrante",
				'A pineapple pomegrante zestified mix of goodness all localy sourced!',
				'$6.50',
				6.50,
				'16oz',
				'organic pomegrante, pineapple, organic granny smith apples, organic lemon juice, green apple.',
				'16oz (1 bottle)',
				new Image(MainView.am.getTexture('juice2'))
			);
			juices[5] = new JuiceVO(
				1,
				'Antioxidant Pro-yum',
				'A boost of berry-blend energy when you need it most. With an added pinch of lemon.',
				'$6.99',
				6.99,
				'16oz',
				'organic raspberries, filtered ionized water, organic lemon, organic mint, organic ginger.',
				'16oz (1 bottle)',
				new Image(MainView.am.getTexture('juice1'))
			);
			
			juices[6] = new JuiceVO(
				2,
				'The Energizer',
				'Strawberry goodness! This juice contains seasonal passionfruit as well! A must have for this season.',
				'$6.99',
				6.99,
				'16oz',
				'organic strawberries, filtered ionized water, organic passionfruit.',
				'16oz (1 bottle)',
				new Image(MainView.am.getTexture('juice2'))
			);
			
			juices[7] = new JuiceVO(
				3,
				'Seeing Green',
				'This juice will change your mind about drinking coffee ever again. A slew of vitamins in this one!',
				'$8.99',
				8.99,
				'16oz',
				'kale, raspberries, filtered ionized water, organic lemon juice, green apple.',
				'16oz (1 bottle)',
				new Image(MainView.am.getTexture('juice3'))
			);
			
			juices[8] = new JuiceVO(
				1,
				"Jon's Kickin' Lemonade",
				'Lemon, orange, lime, grapefruit. A swirl of citrus goodies with a twist of raspberry puree.',
				'$7.00',
				7.00,
				'16oz',
				'organic orange, orangic raspberries, organic lemon juice, organic grapefruit, organic lime.',
				'16oz (1 bottle)',
				new Image(MainView.am.getTexture('juice1'))
			);
			
			juices[9] = new JuiceVO(
				2,
				"Poppin' Pomegrante",
				'A pineapple pomegrante zestified mix of goodness all localy sourced!',
				'$6.50',
				6.50,
				'16oz',
				'organic pomegrante, pineapple, organic granny smith apples, organic lemon juice, green apple.',
				'16oz (1 bottle)',
				new Image(MainView.am.getTexture('juice2'))
			);
		}
	
		
		
	}
}