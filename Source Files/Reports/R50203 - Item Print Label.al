report 50203 "Item Label Print Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ItemLabelReport.rdlc';

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            column(No_Item; Item."No.")
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(CopyNo; CopyNo)
                    {
                    }
                    column(Description_Item; Item.Description)
                    {
                    }
                    column(UOM_Item; Item."Base Unit of Measure")
                    {
                    }
                    column(UnitPrice_Item; Item."Unit Price")
                    {
                    }
                    column(ItemCategoryCode; Item."Item Category Code")
                    {
                    }
                    column(Manufacture; Recmanufacture.Name)
                    {
                    }
                    column(Quantity; Item.Inventory)
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    Item.CalcFields(Inventory);
                    if Recmanufacture.get(Item."Manufacturer Code") then;
                    // CurrReport.PageNo := 1; //CBR_SS
                    if CopyNo = NoLoops then begin
                        CurrReport.Break;
                    end;
                    CopyNo := CopyNo + 1;
                    if CopyNo = 1 then // Original
                        Clear(CopyTxt)
                    else
                        CopyTxt := Text000;
                end;

                trigger OnPreDataItem()
                begin
                    NoLoops := 1 + Abs(NoCopies);
                    if NoLoops <= 0 then
                        NoLoops := 1;
                    CopyNo := 0;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NoCopies; NoCopies)
                    {
                        Caption = 'No. of Copies';
                        ApplicationArea = all;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        NoCopies: Integer;
        NoLoops: Integer;
        CopyNo: Integer;
        NumberOfLines: Integer;
        OnLineNumber: Integer;
        Text000: Label 'Copy';
        CopyTxt: Text[10];
        Recmanufacture: Record Manufacturer;
}

