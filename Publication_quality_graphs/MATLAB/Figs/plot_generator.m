% Plot generation and saving script

% 1. Line Plot - Temperature Trends Over a Year
months = 1:12;
temperatures = [4, 6, 10, 15, 20, 25, 27, 26, 22, 16, 10, 5];
figure;
plot(months, temperatures);
xlabel('Month');
ylabel('Average Temperature (°C)');
title('Monthly Temperature Trends');
savefig('line_plot_temperature.fig');

% 2. Scatter Plot - Height vs Weight of Individuals
heights = [150, 155, 160, 165, 170, 175, 180, 185];
weights = [50, 55, 60, 65, 70, 75, 80, 85];
figure;
scatter(heights, weights);
xlabel('Height (cm)');
ylabel('Weight (kg)');
title('Height vs Weight of Individuals');
savefig('scatter_plot_height_weight.fig');

% 3. Bar Chart - Sales Data for Different Products
products = {'A', 'B', 'C', 'D', 'E'};
sales = [200, 300, 150, 400, 350];
figure;
bar(sales);
set(gca, 'xticklabel', products);
xlabel('Products');
ylabel('Sales ($)');
title('Sales Data for Different Products');
savefig('bar_chart_sales.fig');

% 5. Histogram - Age Distribution of Survey Respondents
ages = [22, 25, 28, 30, 32, 35, 38, 40, 42, 45, 48, 50];
figure;
histogram(ages);
xlabel('Age');
ylabel('Number of Respondents');
title('Age Distribution of Survey Respondents');
savefig('histogram_age_distribution.fig');

% 6. Area Plot - Daily Web Traffic Over a Month
days = 1:30;
traffic = [120, 150, 180, 160, 200, 220, 210, 230, 190, 250, 270, 300, 320, 310, 280, 260, 240, 220, 230, 250, 270, 290, 310, 330, 350, 340, 320, 300, 280, 260];
figure;
area(days, traffic);
xlabel('Day');
ylabel('Web Traffic (Visitors)');
title('Daily Web Traffic Over a Month');
savefig('area_plot_web_traffic.fig');
