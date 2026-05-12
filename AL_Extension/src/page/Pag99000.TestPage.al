page 99000 TestPage
{
    Caption = 'Test Page';
    PageType = Card;

    layout
    {
        area(content)
        {
            field(PageID; PageID)
            {
                Caption = 'N° Page : ';

                trigger OnValidate()
                begin
                    IF PageID <> 0 THEN
                        PAGE.RUN(PageID);
                end;
            }
            field(XMLPortID; XMLPortID)
            {
                Caption = 'N° XML Port : ';

                trigger OnValidate()
                begin
                    IF XMLPortID <> 0 THEN
                        XMLPORT.RUN(XMLPortID);
                end;
            }
            field(ReportID; ReportID)
            {
                Caption = 'Report : ';

                trigger OnValidate()
                begin
                    IF ReportID <> 0 THEN
                        REPORT.RUN(ReportID);
                end;
            }
            field(DataportID; DataportID)
            {
                Caption = 'Dataport : ';

                trigger OnValidate()
                begin
                    //GL2024    IF DataportID <> 0 THEN
                    //GL2024   DATAPORT.RUN(DataportID);
                end;
            }
            field(CodeUnitID; CodeUnitID)
            {
                Caption = 'CodeUnit : ';

                trigger OnValidate()
                begin
                    IF CodeUnitID <> 0 THEN
                        CODEUNIT.RUN(CodeUnitID);
                end;
            }
            field(OkOk; OkOK)
            {
                Caption = 'Lancer l''objet';

                trigger OnValidate()
                begin
                    IF PageID <> 0 THEN
                        PAGE.RUN(PageID);
                    IF XMLPortID <> 0 THEN
                        XMLPORT.RUN(XMLPortID);
                    IF ReportID <> 0 THEN
                        REPORT.RUN(ReportID);
                    IF DataportID <> 0 THEN
                        //GL2024  DATAPORT.RUN(DataportID);
                        IF CodeUnitID <> 0 THEN
                            CODEUNIT.RUN(CodeUnitID);
                end;
            }
        }
    }

    actions
    {
    }

    var
        PageID: Integer;
        XMLPortID: Integer;
        ReportID: Integer;
        DataportID: Integer;
        CodeUnitID: Integer;
        OkOK: Boolean;
}

