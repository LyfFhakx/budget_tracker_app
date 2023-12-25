abstract interface class Either<L, R> {
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight);
  const Either();
}

class Left<L, R> extends Either<L, R> {
  const Left(this._l);

  final L _l;

  @override
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight) => ifLeft(_l);

  @override
  bool operator ==(other) => other is Left && other._l == _l;

  @override
  int get hashCode => _l.hashCode;
}

class Right<L, R> extends Either<L, R> {
  const Right(this._r);

  final R _r;

  @override
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight) => ifRight(_r);

  @override
  bool operator ==(other) => other is Right && other._r == _r;

  @override
  int get hashCode => _r.hashCode;
}
