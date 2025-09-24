# Snappay_data
This project analyzes the impact of different variables on default risk for Snappay which is a LendTech company
The table has 80K rows with these columns:


Column	                 |            Example value	    |     Meaning       
customer_id	                                1	                Unique user ID
age	                                        49	              Demographics
gender	                                    female	          Demographics
external credit score	                      361	              FICO  
total credit usage count                    5	                Number of loans/credits used
total credit usage amount                 	7,383,270	        Total borrowed amount
total full credit usage count               8	                Number of times user maxed out credit
is credit remaining	                        1	                Has remaining credit (0,1)
count of credit upgrade                   	2	                Number of times credit limit increased
total repayment delay count	                5	                in case of more than 5 days of delay
Snapp rides count	                          406	              Engagement in rides
Snapp rides total spent                     46,490,248	      Amount spent on rides
frequent Snapp municipal district         	6                	Demographics/Location
Snappfood orders count	                    487	              Engagement in food
Snappfood total spent     	                367,427,864	      Amount spent on food
frequent Snappfood municipal district	      13	              Demographics/Location
is defaulter                              	0                 Target variable (0,1)


