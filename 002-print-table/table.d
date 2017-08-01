import std.stdio, std.range, std.array, std.string, std.regex, std.algorithm;

void main( string[] args )
{
  auto rr = [
	["r1c1la","r1c2"],
	["r2c1","r2c2lala"],
  ];
  auto h = ["h1","h2"];
  renderTable( h, rr ).writeln;
}

auto maxWidths( string[] header, string[][] rows ){
 ulong[] lengths( string[] r){
  return r.map!"a.length".array;
 }
 return fold!( 
	(ulong[] acc, string[] row)=>zip( acc, lengths(row) ).map!( t=>max( t[0], t[1]) ).array  
  )( rows, lengths(header) );
}

auto renderSeparator(T1)(T1 widths){
  auto pieces(){
	return widths.map!( w=>"-".repeat(w+2).join );
  }
  return "|" ~ pieces.join("+") ~ "|";
}

string pad( string s, ulong length){
  return " " ~ s ~ " ".repeat( length - s.length + 1 ).join;
}

auto renderRow(T1,T2)(T1 row, T2 widths){
  auto padded(){
	return row.zip(widths).map!(
	  t=>pad( t[0], t[1])
	);
  }
  return "|" ~ padded.join("|") ~ "|";
}

auto renderTable(T1,T2)(T1 header, T2 rows){
  auto widths1 = maxWidths( header, rows);
  return only( 
	renderRow( header, widths1 ),
	renderSeparator( widths1)
  ).chain(
	rows.map!( row=>renderRow(row,widths1) )
  ).join("\n");
}