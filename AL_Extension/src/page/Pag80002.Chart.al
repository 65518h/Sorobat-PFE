Page 80002 Chart
{
    Caption = 'Chart';
    PageType = Card;

    layout
    {
        area(content)
        {
            part(ChartContainer; "Chart Sub-Form")
            {
                Editable = false;
                Enabled = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            /*  //GL2024    group(Chart)
              {
                  Caption = 'Chart';
                  action(Type1)
                  {
                      ApplicationArea = Basic;
                      Caption = 'Type1';

                      trigger OnAction()
                      begin

                         //GL2024     DLL4.ChangeChart(1);
                      end;
                  }
                  action(Type2)
                  {
                      ApplicationArea = Basic;
                      Caption = 'Type2';

                      trigger OnAction()
                      begin

                        //GL2024      DLL4.ChangeChart(2);
                      end;
                  }
                  action(Type3)
                  {
                      ApplicationArea = Basic;
                      Caption = 'Type3';

                      trigger OnAction()
                      begin

                        //GL2024      DLL4.ChangeChart(3);
                      end;
                  }
                  action(Type4)
                  {
                      ApplicationArea = Basic;
                      Caption = 'Type4';

                      trigger OnAction()
                      begin

                         //GL2024     DLL4.ChangeChart(4);
                      end;
                  }
                  action(Type5)
                  {
                      ApplicationArea = Basic;
                      Caption = 'Type5';

                      trigger OnAction()
                      begin

                         //GL2024     DLL4.ChangeChart(5);
                      end;
                  }
                  action(Type6)
                  {
                      ApplicationArea = Basic;
                      Caption = 'Type6';

                      trigger OnAction()
                      begin

                 //GL2024             DLL4.ChangeChart(6);
                      end;
                  }
                  action(Type7)
                  {
                      ApplicationArea = Basic;
                      Caption = 'Type7';

                      trigger OnAction()
                      begin

                        //GL2024      DLL4.ChangeChart(7);
                      end;
                  }
                  action(Label1)
                  {
                      ApplicationArea = Basic;
                      Caption = 'Label1';

                      trigger OnAction()
                      begin

                         //GL2024     DLL4.SelectLabels(0, 1, 1);
                      end;
                  }
                  action(Label2)
                  {
                      ApplicationArea = Basic;
                      Caption = 'Label2';

                      trigger OnAction()
                      begin

                        //GL2024      DLL4.SelectLabels(1, 1, 1);
                      end;
                  }
                  action(Label3)
                  {
                      ApplicationArea = Basic;
                      Caption = 'Label3';

                      trigger OnAction()
                      begin

                       //GL2024       DLL4.SelectLabels(1, 0, 1);
                      end;
                  }
                  action(Label4)
                  {
                      ApplicationArea = Basic;
                      Caption = 'Label4';

                      trigger OnAction()
                      begin

                         //GL2024     DLL4.SelectLabels(0, 0, 1);
                      end;
                  }
              }*/
        }
    }

    trigger OnClosePage()
    begin
        //GL2024      DLL4.FreeResources;
        ClearAll();
    end;

    var
    //GL2024    DLL4: Automation ;

    local procedure ChartContainerOnActivate()
    begin

        /*  //GL2024      if ISCLEAR(DLL4) then
            Create(DLL4);

            DLL4.CreateDataArray(5);

            DLL4.InsertValue(0, 10);
            DLL4.InsertValue(1, 2);
            DLL4.InsertValue(2, 20);
            DLL4.InsertValue(3, 100);
            DLL4.InsertValue(4, 100);

            DLL4.InsertLabel(0, 'A');
            DLL4.InsertLabel(1, 'B');
            DLL4.InsertLabel(2, 'C');
            DLL4.InsertLabel(3, 'D');
            DLL4.InsertLabel(4, 'E');

            DLL4.Andre;
    */

        //DLL4.Andre2;
    end;
}

