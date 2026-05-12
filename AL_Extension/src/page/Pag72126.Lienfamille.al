//GL3900 
// Page 72126 "Lien famille"
// {//GL2024  ID dans Nav 2009 : "39002126"
//     //  STRSUBSTNO('%1%2',

//     DeleteAllowed = false;
//     InsertAllowed = false;
//     ModifyAllowed = false;
//     PageType = Card;
//     SourceTable = Liens;
//     SourceTableView = sorting(tri)
//                       order(ascending);
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1000000014)
//             {
//                 IndentationColumn = family_linkIndent;
//                 IndentationControls = family_link;
//                 field(ActualExpansionStatus; ActualExpansionStatus)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Satus';
//                     Editable = false;
//                     //OptionCaption = 'Integer';

//                     trigger OnValidate()
//                     begin
//                         ActualExpansionStatusOnPush;
//                     end;
//                 }
//                 field(family_link; Rec.family_link)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Libellé famille"; Rec."Libellé famille")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group(Fonction)
//             {
//                 Caption = 'Fonction';
//                 action("Expand All")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Expand All';

//                     trigger OnAction()
//                     begin
//                         ExpandAll;
//                     end;
//                 }
//                 action(Masque)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Masque';

//                     trigger OnAction()
//                     begin
//                         InitTemplate
//                     end;
//                 }
//             }
//         }
//         area(processing)
//         {
//             action("Family Card")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Family Card';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     if FAM.Get(Rec.family_link) then
//                         PAGE.Run(90002, FAM);
//                 end;
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         family_linkIndent := 0;
//         if IsExpanded(Rec) then
//             ActualExpansionStatus := 1
//         else
//             if HasChildren(Rec) then
//                 ActualExpansionStatus := 0
//             else
//                 ActualExpansionStatus := 2;
//         familylinkOnFormat;
//     end;

//     trigger OnFindRecord(Which: Text): Boolean
//     var
//         found: Boolean;
//     begin
//         TempRec.Copy(Rec);
//         found := TempRec.Find(Which);
//         Rec := TempRec;
//         exit(found);
//     end;

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     var
//         RecRef: RecordRef;
//         ChangeLogMgt: Codeunit "Change Log Management";
//     begin
//         TempRec := Rec;
//         RecRef.GetTable(Rec);
//         ChangeLogMgt.LogInsertion(RecRef);
//         exit(TempRec.Insert);
//     end;

//     trigger OnNextRecord(Steps: Integer): Integer
//     var
//         ResultSteps: Integer;
//     begin
//         TempRec.Copy(Rec);
//         ResultSteps := TempRec.Next(Steps);
//         Rec := TempRec;
//         exit(ResultSteps);
//     end;

//     trigger OnOpenPage()
//     begin
//         InitTemplate;
//         if compoTmp.tri <> '' then begin
//             Rec.SetFilter(tri, '%1..%2', compoTmp.tri, (CopyStr(compoTmp.tri, 1, 3) +
//              '999999999999999999999999999999'));
//             ExpandAll;
//         end;
//     end;

//     var
//         ActualExpansionStatus: Integer;
//         TempRec: Record Liens temporary;
//         FAM: Record Famille;
//         temp: Record Liens;
//         compoTmp: Record Liens;
//         [InDataSet]
//         family_linkEmphasize: Boolean;
//         [InDataSet]
//         family_linkIndent: Integer;


//     procedure InitTemplate()
//     begin
//         CopyRecToTemp(true);
//     end;


//     procedure CopyRecToTemp(onlyRoot: Boolean)
//     var
//         HierRec: Record Liens;
//     begin
//         TempRec.DeleteAll;
//         TempRec.SetCurrentkey(cd_compo);
//         if onlyRoot then
//             HierRec.SetRange(HierRec.identation, 0);
//         HierRec.SetFilter(HierRec.typ_subtype, '2');
//         if HierRec.Find('-') then
//             repeat
//                 TempRec := HierRec;
//                 TempRec.Insert;
//             until HierRec.Next = 0;
//     end;


//     procedure ToogleExpand(compo: Record Liens)
//     begin
//         if ActualExpansionStatus = 0 then begin // Has children, but not expanded

//             /* compo.SETFILTER(typ_subtype,'1');
//              compo.SETFILTER(compo.cd_box,cd_box_link);
//              compo.SETRANGE(identation,identation + 1);
//              compo := Rec;*/
//             temp.Reset;
//             temp.SetFilter(temp.family, compo.family_link);
//             temp.SetRange(temp.identation, compo.identation + 1);
//             compo := temp;

//             //IF compo.NEXT <> 0 THEN
//             if temp.Find('-') then
//                 repeat
//                     if temp.identation > Rec.identation then begin
//                         TempRec := temp;
//                         TempRec.SetCurrentkey(TempRec.tri);
//                         // temprec.ascending(false);
//                         if TempRec.Insert then;
//                     end;
//                 until (temp.Next = 0) or (temp.identation = Rec.identation);
//         end else
//             if ActualExpansionStatus = 1 then begin // Has children and is already expanded
//                 TempRec := Rec;
//                 while (TempRec.Next <> 0) and (TempRec.identation > Rec.identation) do
//                     TempRec.Delete;
//             end;
//         CurrPage.Update;

//     end;


//     procedure HasChildren(ActualRec: Record Liens): Boolean
//     var
//         compo: Record Liens;
//     begin
//         compo := ActualRec;

//         compo.Reset;
//         compo.SetFilter(compo.family, ActualRec.family_link);

//         //IF compo.NEXT = 0 THEN
//         if not compo.Find('-') then
//             exit(false)
//         else
//             exit(compo.identation > ActualRec.identation);
//     end;


//     procedure IsExpanded(ActualRec: Record Liens): Boolean
//     begin
//         TempRec := ActualRec;

//         TempRec.Reset;
//         TempRec.SetFilter(TempRec.family, ActualRec.family_link);

//         //IF TempRec.NEXT = 0 THEN
//         if not TempRec.Find('-') then
//             exit(false)
//         else
//             exit(TempRec.identation > ActualRec.identation);
//     end;


//     procedure ExpandAll()
//     begin
//         CopyRecToTemp(false);
//     end;


//     procedure InitArb(var Rec: Record Liens)
//     begin
//         Clear(compoTmp);
//         compoTmp := Rec;
//     end;

//     local procedure ActualExpansionStatusOnPush()
//     begin
//         ToogleExpand(Rec);
//     end;

//     local procedure familylinkOnFormat()
//     begin
//         if Rec.identation = 0 then
//             family_linkEmphasize := true;

//         if Rec.identation > 0 then
//             family_linkIndent := Rec.identation * 300;
//     end;
// }

