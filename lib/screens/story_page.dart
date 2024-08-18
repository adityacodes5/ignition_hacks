import 'package:flutter/material.dart';

class StoryPage extends StatefulWidget {
  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  int _currentPage = 0;

  final List<Map<String, String>> _storyContent = [
    {
      'title': 'Budgeting Basics: How to Create Your Own Budget',
      'image':
          'https://cdn.discordapp.com/attachments/1273633503002497144/1274583945240903781/Budget.png?ex=66c2c84d&is=66c176cd&hm=13a3b8d23bfb806b2113eff57c6c8c39a5c02d6c0c01bb0979bc11852093fa3d&', // Add image path here
      'content':
          'Budgeting is the most essential skill to learn for financial success. Whether you’re aiming to save for a big purchase, pay off debt, or simply try to take control of your finances, having a well-structured budget can be your guide.\n\nIn this tutorial, we’ll walk you through the basics of creating a budget and provide tips on how to stick to it.'
    },
    {
      'title': 'Understanding Total Income',
      'image':
          'https://cdn.discordapp.com/attachments/1273633503002497144/1274584058336378882/Budgeting-Graphic.png?ex=66c2c868&is=66c176e8&hm=1f3c9277ce527b703acfd319c5772ccb103146686517391a1181b541879dd701&', // Add image path here
      'content':
          'Your budget starts with knowing exactly how much money you have to work with. By adding up all sources of earnings, you can calculate your total monthly income. There are 3 types of incomes:\n\nPrimary Income: Your take-home pay after taxes.\nSide Income: Earning from side jobs, freelance work, or part-time gigs.\nPassive Income: The money from investments, dividends, or rental properties.\n\nUnderstanding your income is crucial because it sets the limit for your spending and saving. A clear picture of your financial inflows ensures that you set the budget based on realistic numbers. Without having an accurate understanding of your income, you become prone to overspending or under-saving, which can derail your financial goals.'
    },
    {
      'title': 'Tracking and Categorizing Every Expense',
      'image':
          'https://cdn.discordapp.com/attachments/1273633503002497144/1274584280177311774/learntobudget.png?ex=66c2c89d&is=66c1771d&hm=3cd0e2492832d61be0a27e0b7bcf37f5e1665caae1e130f2c2028fa7de67b6e4&', // Add image path here
      'content':
          'The next step is to identify where your money is going. Start by tracking all your expenses over a month, and then categorize them. Here are the types of expenses:\n\nFixed Expenses: These are obligatory costs that remain the same each month, like rent or mortgage payments, utility bills, insurance premiums, and loan payments.\nVariable Expenses: These fluctuate based on usage or choice, such as groceries, dining out, entertainment, clothing, and transportation.\n\nBy categorizing your expenses, you’ll understand your spending habits and spot areas where you can cut back. It’s vital to be thorough – by including even the smallest purchases. By knowing exactly where your money goes, you gain the power to make informed decisions about how to allocate it more effectively.'
    },
    {
      'title': 'Setting Realistic Financial Goals and Prioritizing Them',
      'image':
          'https://cdn.discordapp.com/attachments/1273633503002497144/1274584354831597599/activity-based-budgeting-1024x683.png?ex=66c2c8ae&is=66c1772e&hm=3c3300794ed82e37a4f90e875df1a41ce83ceafb7a07411ce6236ae640a5ba83&', // Add image path here
      'content':
          'Your budget should reflect what you want to achieve financially. Whether it’s paying off debt, saving for a home, building an emergency fund, or planning a simple vacation, setting clear and realistic goals gives your budget a sense of purpose. Break down your goals into:\n\nShort-Term Goals: Goals you plan to achieve within a year, such as saving \$1,000 for an emergency fund or paying off a credit card balance.\nLong-Term Goals: These are goals that take several years to achieve, like buying a house, funding your retirement, or paying off a large loan.\n\nPrioritize your goals based on urgency and impact. For instance, building an emergency fund might take precedence over saving for a vacation. By linking your budget to specific goals, you’ll stay motivated and focused, making it easier to stick to your budget over time.'
    },
    {
      'title': 'Monitoring and Sticking to Your Budget',
      'image':
          'https://cdn.discordapp.com/attachments/1273633503002497144/1274586316654383134/Types-of-Budgets_-6-Common-Budgeting-Methods-for-Business.png?ex=66c2ca82&is=66c17902&hm=a14580cb377ba7cb34b0dddecfca526724406004ddf2326857c8e1e2b2f9a6c6&', // Add image path here
      'content':
          'Creating a budget is only half the battle – sticking to it requires regular monitoring and flexibility. After setting your budget, be sure to track your spending and compare it against your budgeted amounts:\n\nMonitor Spending: Use Coin Cabin to track every expense, keeping you aware of your spending habits and spot trends.\nAdjust as Needed: Life changes, and so will your budget. If your income fluctuates or you face unexpected expenses, adjust the budget accordingly. Don’t be afraid to reallocate funds from one category to another.\nStick to Consistency: The key to success is consistency. Regularly review your budget, celebrate small wins, and make adjustments as needed. If you overspend in one category, compensate by cutting back in another.\n\nMonitoring your budget ensures you remain in control of your finances. It’s a living document that can help you grow with your life. By staying on top of your spending and setting priorities, you can avoid financial pitfalls and stay on track to meet your goals.'
    },
    {
      'title': 'Conclusion',
      'image':
          'https://cdn.discordapp.com/attachments/1273633503002497144/1274574264607051808/Budgeting_1920x1080.png?ex=66c2bf49&is=66c16dc9&hm=ec7cce91cc77d60cbbbf35e829241a9967b1f74e0a19702834bf726e82e1e219&', // Add image path here
      'content':
          'These four steps provide a simple yet powerful structure for managing your money. By understanding your income, tracking expenses, setting clear goals and priorities, and regularly monitoring your budget, you can take charge of your finances and build a more secure future. The key is to stay disciplined, remain flexible, and always keep your financial priorities in sight.'
    },
  ];

  void _nextPage() {
    setState(() {
      if (_currentPage < _storyContent.length - 1) {
        _currentPage++;
      } else {
        Navigator.pop(context); // Pops the navigator back when done
      }
    });
  }

  void _previousPage() {
    setState(() {
      if (_currentPage > 0) {
        _currentPage--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Budgeting Basics"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image container (Replace with your actual image logic)
            Container(
              height: 200,
              color: Colors.grey[300], // Placeholder for image
              child: Center(
                child: Image.network('${_storyContent[_currentPage]['image']}'),
              ),
            ),
            SizedBox(height: 24),
            // Subtitle
            Text(
              _storyContent[_currentPage]['title']!,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            // Story content
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _storyContent[_currentPage]['content']!,
                  style: TextStyle(fontSize: 16, height: 1.5),
                ),
              ),
            ),
            SizedBox(height: 24),
            // Navigation buttons
            Row(
              mainAxisAlignment: _currentPage > 0
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.end,
              children: [
                if (_currentPage > 0)
                  TextButton.icon(
                    onPressed: _previousPage,
                    icon: Icon(Icons.arrow_back),
                    label: Text('Back'),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 12.0),
                    ),
                  ),
                TextButton.icon(
                  onPressed: _nextPage,
                  icon: Text(_currentPage < _storyContent.length - 1
                      ? 'Next'
                      : 'Done'),
                  label: Icon(
                    _currentPage < _storyContent.length - 1
                        ? Icons.arrow_forward
                        : Icons.check,
                  ),
                  style: TextButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
