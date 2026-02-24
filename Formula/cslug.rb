class Cslug < Formula
  desc "Compiler for the CSlug programming language"
  homepage "https://github.com/stravigor/cslug"
  url "https://github.com/stravigor/cslug.git",
      using:    :git,
      tag:      "v0.1.0",
      revision: "8721bbb301445154b75cd3720b1885074c8df2de"
  license "MIT"

  depends_on "cmake" => :build
  depends_on "llvm"

  def install
    system "cmake", "-S", ".", "-B", "build",
           "-DCSLUG_RUNTIME_DIR_OVERRIDE=#{lib}",
           "-DCMAKE_BUILD_TYPE=Release",
           *std_cmake_args
    system "cmake", "--build", "build"
    bin.install "build/tools/cslug/cslug"
    lib.install "build/lib/Runtime/libcslug_runtime.a"
  end

  test do
    (testpath/"hello.cslug").write <<~EOS
      extern int printf(char* fmt, ...);
      int main() {
        printf("Hello\\n");
        return 0;
      }
    EOS
    system bin/"cslug", "hello.cslug", "-o", "hello"
    assert_equal "Hello\n", shell_output("./hello")
  end
end
