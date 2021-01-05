{ lib, pythonPackages, python3, gfortran, fftw }:

python3.pkgs.buildPythonPackage rec {
  pname = "pyshtools";
  version = "4.6";
  
  src = pythonPackages.fetchPypi {
    inherit pname version;
    sha256 = "0ck3ikxhwric4s65fg1q6ffbrak4xcx8va9hbgaigmdlmv2308n8";
  };
  
  doCheck = false;

  propagatedBuildInputs = [ python3.pkgs.pooch python3.pkgs.tqdm python3.pkgs.requests python3.pkgs.xarray python3.pkgs.numpy python3.pkgs.scipy python3.pkgs.matplotlib python3.pkgs.astropy ];
  nativeBuildInputs = [ gfortran ];
  buildInputs = [ gfortran python3 fftw ];

  preConfigure = ''
    export LDFLAGS="-shared -L${python3}/lib -L${fftw}/lib -lfftw3"
    export CFLAGS="-I${python3}/include/python3.7 -I${python3.pkgs.numpy}/lib/python3.7/site-packages/numpy/f2py/src"
  '';

  patches = [
    ./kill-fftw-test.patch
  ];
  
  meta = with lib; {
    homepage = https://github.com/SHTOOLS/SHTOOLS;
    description = "Spherical Harmonic Tools";
    license = licenses.bsd3;
    maintainers = with maintainers; [ kisonecat ];
  };
}
