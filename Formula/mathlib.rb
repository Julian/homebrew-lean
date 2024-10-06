class Mathlib < Formula
  desc "Mathematics library for Lean 4"
  homepage "https://github.com/leanprover-community/mathlib4"
  url "https://github.com/leanprover-community/mathlib4/archive/refs/tags/nightly-testing-2024-10-03.tar.gz"
  sha256 "26e4de9c9149a3bef78e0f67bb31e310114a4e618cfb01965acfb88c27e77df3"
  license "Apache-2.0"
  head "https://github.com/leanprover-community/mathlib4.git", branch: "master"

  depends_on "julian/lean/lean"
  depends_on macos: :mojave

  conflicts_with "elan-init", because: "it installs the same binaries"

  def install
    system "lake", "build"
    prefix.install Dir["*"]
  end

  test do
    (testpath/"hello.lean").write <<~EOS
      import Mathlib.Data.Set.Basic
      #check Nat
    EOS
    system "lake", "run", testpath/"hello.lean"
  end
end
